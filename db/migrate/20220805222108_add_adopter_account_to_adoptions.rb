class AddAdopterAccountToAdoptions < ActiveRecord::Migration[7.0]
  def change
    add_reference :adoptions, :adopter_account, null: false, foreign_key: true
  end
end
