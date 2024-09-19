class RemoveAccountFromLikes < ActiveRecord::Migration[7.1]
  def change
    safety_assured do
      remove_reference :likes, :adopter_foster_account, foreign_key: true, null: false
    end
  end
end
