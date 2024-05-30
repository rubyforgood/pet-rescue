class IndexAdopterApplicationsOnAccountAndPet < ActiveRecord::Migration[7.0]
  def change
    add_index :adopter_applications, [:pet_id, :adopter_foster_account_id],
      unique: true,
      name: "index_adopter_applications_on_account_and_pet"
  end
end
