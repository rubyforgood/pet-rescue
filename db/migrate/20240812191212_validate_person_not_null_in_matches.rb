class ValidatePersonNotNullInMatches < ActiveRecord::Migration[7.1]
  def up
    validate_check_constraint :matches, name: "matches_person_id_null"
    change_column_null :matches, :person_id, false
    remove_check_constraint :matches, name: "matches_person_id_null"
  end

  def down
    add_check_constraint :matches, "person_id IS NOT NULL",
      name: "matches_person_id_null", validate: false
    change_column_null :matches, :person_id, true
  end
end
