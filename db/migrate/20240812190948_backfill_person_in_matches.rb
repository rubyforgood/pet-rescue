class BackfillPersonInMatches < ActiveRecord::Migration[7.1]
  def up
    Match.where(person_id: nil).each do |match|
      match.update!(person_id: get_person_id(match))
    end
  end

  private

  def get_person_id(match)
    match.adopter_foster_account.user.person_id
  end
end
