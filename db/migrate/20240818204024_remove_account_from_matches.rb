class RemoveAccountFromMatches < ActiveRecord::Migration[7.1]
  def change
    safety_assured do
      remove_reference :matches, :adopter_foster_account,
        index: true, foreign_key: true, null: false
    end
  end
end
