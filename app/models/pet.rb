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
#  pause_reason       :integer          default("not_paused")
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
  enum species: ["dog", "cat"]

  validates :name, presence: true
  validates :birth_date, presence: true
  validates :breed, presence: true
  validates :sex, presence: true
  validates :weight_from, presence: true, numericality: {only_integer: true}
  validates :weight_to, presence: true, numericality: {only_integer: true}
  validates :weight_unit, presence: true
  validates :weight_unit, inclusion: {in: %w[lb kg]}
  validates_comparison_of :weight_to, greater_than: :weight_from
  validates :description, presence: true, length: {maximum: 1000}

  # active storage validations gem
  validates :images, content_type: {in: ["image/png", "image/jpeg"],
                                    message: "must be PNG or JPEG"},
    limit: {max: 5, message: "- 5 maximum"},
    size: {between: 10.kilobyte..1.megabytes,
           message: "size must be between 10kb and 1Mb"}

  enum :pause_reason, [:not_paused,
    :opening_soon,
    :paused_until_further_notice]

  WEIGHT_UNIT_LB = "lb".freeze
  WEIGHT_UNIT_KG = "kg".freeze

  WEIGHT_UNITS = [
    WEIGHT_UNIT_LB,
    WEIGHT_UNIT_KG
  ]

  # check if pet has any applications with adoption pending status
  def has_adoption_pending?
    adopter_applications.any? { |app| app.status == "adoption_pending" }
  end

  # remove not_paused status as not necessary for staff
  def self.app_pause_reasons
    Pet.pause_reasons.keys.map do |reason|
      [reason.titleize, reason]
    end.drop(1)
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
    Pet.org_pets(staff_org_id).includes(:adopter_applications).where
      .not(adopter_applications: {id: nil}).includes(:match)
      .where(match: {id: nil})
  end

  # all unadopted pets under all organizations
  def self.all_unadopted_pets
    Pet.includes(:match).where(match: {id: nil})
  end

  # all unadopted pets under an organization
  def self.unadopted_pets(staff_org_id)
    Pet.org_pets(staff_org_id).includes(:match).where(match: {id: nil})
  end

  # all adopted pets under an organization
  def self.adopted_pets(staff_org_id)
    Pet.org_pets(staff_org_id).includes(:match)
      .where.not(match: {id: nil})
  end
end
