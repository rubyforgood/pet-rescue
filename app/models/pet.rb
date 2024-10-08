# == Schema Information
#
# Table name: pets
#
#  id                 :bigint           not null, primary key
#  application_paused :boolean          default(FALSE), not null
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
  include PetTaskable

  acts_as_tenant(:organization)

  has_many :adopter_applications, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :matches, dependent: :destroy
  has_many :likes, dependent: :destroy
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

  validate :sensible_placement_type

  enum species: {"Dog" => 1, "Cat" => 2}
  enum placement_type: ["Adoptable", "Fosterable", "Adoptable and Fosterable"]

  WEIGHT_UNIT_LB = "lb".freeze
  WEIGHT_UNIT_KG = "kg".freeze

  WEIGHT_UNITS = [
    WEIGHT_UNIT_LB,
    WEIGHT_UNIT_KG
  ]

  scope :adopted, -> { joins(:matches).merge(Match.adoptions) }
  scope :unadopted, -> { where.not(id: Pet.adopted) }
  scope :unmatched, -> { includes(:matches).where(matches: {id: nil}) }
  scope :published, -> { where(published: true) }
  scope :fostered, -> { joins(:matches).merge(Match.fosters) }
  scope :fosterable, -> {
    where(placement_type: ["Fosterable", "Adoptable and Fosterable"])
  }
  scope :with_photo, -> { where.associated(:images_attachments) }
  scope :filter_by_application_status, ->(status_filter) {
    joins(:adopter_applications).where(adopter_applications: {status: status_filter})
  }

  attr_writer :toggle

  # check if pet has any applications with adoption pending status
  def has_adoption_pending?
    adopter_applications.any? { |app| app.status == "adoption_pending" }
  end

  def is_adopted?
    adopter_applications.any? { |app| app.status == "adoption_made" }
  end

  def in_foster?
    matches.in_foster.exists?
  end

  def open?
    !is_adopted? && !in_foster?
  end

  # active storage: using.attach for appending images per rails guide
  def append_images=(attachables)
    images.attach(attachables)
  end

  def sensible_placement_type
    if matches.where(end_date: DateTime.now..).exists? && placement_type == "Adoptable"
      errors.add(:placement_type, I18n.t("activerecord.errors.models.pet.attributes.placement_type.sensible"))
    end
  end

  def self.ransackable_attributes(auth_object = nil)
    ["name", "sex", "species", "breed"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["adopter_applications"]
  end

  def self.ransackable_scopes(auth_object = nil)
    [:ransack_adopted, :ransack_birth_date]
  end

  # Using string values to get around ransack bug: https://github.com/activerecord-hackery/ransack/issues/1375
  def self.ransack_adopted(adoption_state)
    (adoption_state == "adopted") ? adopted : unadopted
  end

  def self.ransack_birth_date(date)
    start_date, end_date = date.split("/")

    if start_date != "none" && end_date != "none"
      where("birth_date >= ? AND birth_date <= ?", start_date, end_date)
    elsif start_date == "none" && end_date != "none"
      where("birth_date <= ?", end_date)
    elsif start_date != "none" && end_date == "none"
      where("birth_date >= ?", start_date)
    end
  end
end
