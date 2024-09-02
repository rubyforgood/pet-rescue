class RemovePetAdopterFosterAccountIndexFromAdopterApplications < ActiveRecord::Migration[7.1]
  def change
    remove_index :adopter_applications, column: [:pet_id, :adopter_foster_account_id], name: :index_adopter_applications_on_account_and_pet
  end
end
