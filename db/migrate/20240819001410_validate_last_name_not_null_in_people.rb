class ValidateLastNameNotNullInPeople < ActiveRecord::Migration[7.1]
  def change
    validate_check_constraint :people, name: "people_last_name_null"
    change_column_null :people, :last_name, false
    remove_check_constraint :people, name: "people_last_name_null"
  end
end
