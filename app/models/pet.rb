# == Schema Information
#
# Table name: pets
#
#  id                 :bigint           not null, primary key
#  application_paused :boolean          default(FALSE)
#  birth_date         :datetime         not null
#  breed              :string
#  description        :text
#  name               :string
#  placement_type     :integer          not null
#  published          :boolean          default(FALSE), not null
#  sex                :string
#  species            :integer          not null
#  weight_from        :integer          not null
#  weight_to          :integer          not null
#  weight_unit        :string           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  organization_id    :bigint           not null
#
# Indexes
#
#  index_pets_on_organization_id  (organization_id)
#
# Foreign Keys
#
#  fk_rails_...  (organization_id => organizations.id)
#
class Pet < ApplicationRecord
  acts_as_tenant(:organization)

  has_many :adopter_applications, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_one :match, dependent: :destroy
  has_many_attached :images
  has_many_attached :files

  validates :name, presence: true
  validates :birth_date, presence: true
  validates :breed, presence: true
  validates :published, inclusion: [true, false]
  validates :sex, presence: true
  validates :species, presence: true
  validates :placement_type, presence: true
  validates :weight_from, presence: true, numericality: {only_integer: true}
  validates :weight_to, presence: true, numericality: {only_integer: true}
  validates :weight_unit, presence: true
  validates :weight_unit, inclusion: {in: %w[lb kg]}
  validates_comparison_of :weight_to, greater_than: :weight_from
  validates :description, presence: true, length: {maximum: 1000}

  # active storage validations gem
  validates :images, content_type: {in: ["image/png", "image/jpeg"]},
    limit: {max: 5},
    size: {between: 10.kilobyte..1.megabytes}

  validates :files, content_type: {in: ["image/png", "image/jpeg", "application/pdf"]},
    limit: {max: 15, message: "- 15 maximum"},
    size: {between: 10.kilobyte..2.megabytes}

  enum species: ["Dog", "Cat"]
  enum placement_type: ["Adoptable", "Fosterable", "Adoptable and Fosterable"]

  WEIGHT_UNIT_LB = "lb".freeze
  WEIGHT_UNIT_KG = "kg".freeze

  WEIGHT_UNITS = [
    WEIGHT_UNIT_LB,
    WEIGHT_UNIT_KG
  ]

  scope :adopted, -> { Pet.includes(:match).where.not(match: {id: nil}) }
  scope :unadopted, -> { Pet.includes(:match).where(match: {id: nil}) }
  scope :published, -> { where(published: true) }

  attr_writer :toggle

  # check if pet has any applications with adoption pending status
  def has_adoption_pending?
    adopter_applications.any? { |app| app.status == "adoption_pending" }
  end

  # active storage: using.attach for appending images per rails guide
  def append_images=(attachables)
    images.attach(attachables)
  end

  # all pets under an organization
  def self.org_pets(staff_org_id)
    Pet.where(organization_id: staff_org_id)
  end

  # all pets under an organization with applications and no adoptions
  def self.org_pets_with_apps(staff_org_id)
    Pet.org_pets(staff_org_id).includes(adopter_applications: [adopter_account: [:user]]).where
      .not(adopter_applications: {id: nil}).includes(:match)
      .where(match: {id: nil})
  end

  # all unadopted pets under all organizations
  def self.all_unadopted_pets
    Pet.includes(:match).where(match: {id: nil})
  end

  def self.ransackable_attributes(auth_object = nil)
    ["name", "sex", "species"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["adopter_applications"]
  end

  def self.ransackable_scopes(auth_object = nil)
    [:ransack_adopted]
  end

  def self.ransack_adopted(boolean)
    boolean ? adopted : unadopted
  end
end
