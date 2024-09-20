class BackfillNamesInPeople < ActiveRecord::Migration[7.1]
  def up
    Person.find_each do |person|
      first_name, last_name = person.name.split(" ")
      person.update!(first_name:, last_name:)
    end
  end

  def down
  end
end
