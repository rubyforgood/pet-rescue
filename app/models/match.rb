# == Schema Information
#
# Table name: matches
#
#  id              :bigint           not null, primary key
#  end_date        :datetime
#  match_type      :integer          not null
#  start_date      :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organization_id :bigint           not null
#  person_id       :bigint           not null
#  pet_id          :bigint           not null
#
# Indexes
#
#  index_matches_on_organization_id  (organization_id)
#  index_matches_on_person_id        (person_id)
#  index_matches_on_pet_id           (pet_id)
#
# Foreign Keys
#
#  fk_rails_...  (person_id => people.id)
#  fk_rails_...  (pet_id => pets.id)
#
class Match < ApplicationRecord
  acts_as_tenant(:organization)
  belongs_to :pet, touch: true
  belongs_to :person

  has_one :user, through: :person # TODO: Remove this association

  validates :start_date,
    presence: {if: -> { match_type == "foster" }}
  validates :end_date,
    presence: {if: -> { match_type == "foster" }},
    comparison: {
      if: -> { !!start_date },
      greater_than: :start_date, message: "must be after %{value}"
    }

  validate :belongs_to_same_organization_as_pet, if: -> { pet.present? }

  enum :match_type, [:adoption, :foster]

  scope :adoptions, -> { where(match_type: :adoption) }
  scope :fosters, -> { where(match_type: :foster) }

  scope :in_foster, -> { fosters.where("? between start_date and end_date", Time.zone.now) }

  def self.foster_statuses
    ["complete", "upcoming", "current"]
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[status]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[pet user person]
  end

  def fosterer_name(format = :default)
    user.full_name(format)
  end

  def status
    return :not_applicable if start_date.nil? || end_date.nil?

    current = Time.current

    if current > end_date
      :complete
    elsif current < start_date
      :upcoming
    else
      :current
    end
  end

  def withdraw_application
    adopter_application&.withdraw
  end

  def retire_applications(application_class: AdopterApplication)
    application_class.retire_applications(pet_id: pet_id)
  end

  private

  def belongs_to_same_organization_as_pet
    if organization_id != pet.organization_id
      errors.add(:organization_id, :different_organization)
    end
  end

  def adopter_application
    AdopterApplication.includes(:form_submission).find_by(pet:, form_submission: {person:})
  end

  ransacker :status do
    Arel.sql(
      <<~SQL.squish
        CASE
          WHEN start_date IS NULL OR end_date IS NULL THEN 'not_applicable'
          WHEN CURRENT_TIMESTAMP > end_date THEN 'complete'
          WHEN CURRENT_TIMESTAMP < start_date THEN 'upcoming'
          ELSE 'current'
        END
      SQL
    )
  end
end
