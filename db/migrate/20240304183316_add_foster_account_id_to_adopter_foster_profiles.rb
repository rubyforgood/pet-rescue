class AddFosterAccountIdToAdopterFosterProfiles < ActiveRecord::Migration[7.0]
  def change
    add_reference :adopter_foster_profiles, :foster_account, foreign_key: true
  end
end
