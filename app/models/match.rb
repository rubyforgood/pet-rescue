# == Schema Information
#
# Table name: matches
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  person_id  :bigint
#  pet_id     :bigint           not null
#
# Indexes
#
#  index_matches_on_person_id  (person_id)
#  index_matches_on_pet_id     (pet_id)
#
# Foreign Keys
#
#  fk_rails_...  (pet_id => pets.id)
#
class Match < ApplicationRecord
  belongs_to :pet
  belongs_to :person

  after_create_commit :send_checklist_reminder

  def send_checklist_reminder
    MatchMailer.checklist_reminder(self).deliver_later
  end
end
