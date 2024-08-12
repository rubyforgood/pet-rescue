class SetPersonNotNullInMatches < ActiveRecord::Migration[7.1]
  def change
    add_check_constraint :matches,
      "person_id IS NOT NULL",
      name: "matches_person_id_null",
      validate: false
  end
end
