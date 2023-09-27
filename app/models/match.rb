# == Schema Information
#
# Table name: matches
#
#  id                 :bigint           not null, primary key
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  adopter_account_id :bigint           not null
#  organization_id    :bigint           not null
#  pet_id             :bigint           not null
#
# Indexes
#
#  index_matches_on_adopter_account_id  (adopter_account_id)
#  index_matches_on_organization_id     (organization_id)
#  index_matches_on_pet_id              (pet_id)
#
# Foreign Keys
#
#  fk_rails_...  (adopter_account_id => adopter_accounts.id)
#  fk_rails_...  (pet_id => pets.id)
#
class Match < ApplicationRecord
  acts_as_tenant(:organization)
  belongs_to :pet
  belongs_to :adopter_account
  has_many :checklist_assignments, dependent: :destroy

  validate :belongs_to_same_organization_as_pet, if: -> { pet.present? }

  after_create_commit :send_checklist_reminder

  def send_checklist_reminder
    MatchMailer.checklist_reminder(self).deliver_later
  end

  def assign_checklist_template(checklist_template)
    checklist_template.items.each do |item|
      checklist_assignments.create!(checklist_template_item: item)
    end
  end

  private

  def belongs_to_same_organization_as_pet
    if organization_id != pet.organization_id
      errors.add(:organization_id, "must belong to same organization as pet")
    end
  end
end
