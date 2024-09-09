class RemoveAdopterFosterAccountFromAdopterApplications < ActiveRecord::Migration[7.1]
  def change
    safety_assured do
      remove_reference :adopter_applications, :adopter_foster_account, foreign_key: true
    end
  end
end
