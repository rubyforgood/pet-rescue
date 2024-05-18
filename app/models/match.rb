# == Schema Information
#
# Table name: matches
#
#  id                        :bigint           not null, primary key
#  end_date                  :datetime
#  match_type                :integer          not null
#  start_date                :datetime
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  adopter_foster_account_id :bigint           not null
#  organization_id           :bigint           not null
#  pet_id                    :bigint           not null
#
# Indexes
#
#  index_matches_on_adopter_foster_account_id  (adopter_foster_account_id)
#  index_matches_on_organization_id            (organization_id)
#  index_matches_on_pet_id                     (pet_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (adopter_foster_account_id => adopter_foster_accounts.id)
#  fk_rails_...  (pet_id => pets.id)
#
class Match < ApplicationRecord
  acts_as_tenant(:organization)
  belongs_to :pet
  belongs_to :adopter_foster_account

  has_one :user, through: :adopter_foster_account

  validate :belongs_to_same_organization_as_pet, if: -> { pet.present? }
  validates :pet, uniqueness: true

  after_create_commit :send_reminder

  enum :match_type, [:adoption, :foster]

  scope :fosters, -> { where(match_type: :foster) }

  def self.foster_statuses
    ["complete", "upcoming", "current"]
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[status]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[pet user]
  end

  def fosterer_name(format = :default)
    case format
    when :default
      "#{user.first_name} #{user.last_name}"
    when :last_first
      "#{user.last_name}, #{user.first_name}"
    end
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

  def send_reminder
    MatchMailer.reminder(self).deliver_later
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
    AdopterApplication.find_by(pet:, adopter_foster_account:)
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
