class ValidateFirstNameNotNullInPeople < ActiveRecord::Migration[7.1]
  def change
    validate_check_constraint :people, name: "people_first_name_null"
    change_column_null :people, :first_name, false
    remove_check_constraint :people, name: "people_first_name_null"
  end
end
