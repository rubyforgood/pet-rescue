class SetFirstNameAndLastNameInPeopleNotNull < ActiveRecord::Migration[7.1]
  def change
    add_check_constraint :people, "first_name IS NOT NULL", name: "people_first_name_null", validate: false
    add_check_constraint :people, "last_name IS NOT NULL", name: "people_last_name_null", validate: false
  end
end
