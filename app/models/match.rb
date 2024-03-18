# == Schema Information
#
# Table name: matches
#
#  id                        :bigint           not null, primary key
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  adopter_foster_account_id :bigint
#  organization_id           :bigint           not null
#  pet_id                    :bigint           not null
#
# Indexes
#
#  index_matches_on_adopter_foster_account_id  (adopter_foster_account_id)
#  index_matches_on_organization_id            (organization_id)
#  index_matches_on_pet_id                     (pet_id)
#
# Foreign Keys
#
#  fk_rails_...  (pet_id => pets.id)
#
class Match < ApplicationRecord
  acts_as_tenant(:organization)
  belongs_to :pet
  belongs_to :adopter_foster_account

  validate :belongs_to_same_organization_as_pet, if: -> { pet.present? }

  after_create_commit :send_reminder

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
end
