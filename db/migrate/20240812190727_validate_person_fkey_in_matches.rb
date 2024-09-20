class ValidatePersonFkeyInMatches < ActiveRecord::Migration[7.1]
  def change
    validate_foreign_key :matches, :people
  end
end
