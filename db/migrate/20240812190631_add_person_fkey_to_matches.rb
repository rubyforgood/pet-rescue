class AddPersonFkeyToMatches < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :matches, :people, validate: false
  end
end
