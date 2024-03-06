class AddFosterAccountToAdopterFosterProfiles < ActiveRecord::Migration[7.0]
  def change
    unless column_exists?(:adopter_foster_profiles, :foster_account_id)
      add_reference :adopter_foster_profiles, :foster_account, null: false, foreign_key: true
    end
  end
end
