class EditPeopleTable < ActiveRecord::Migration[7.0]
  def change
    add_column :people, :first_name, :string
    add_column :people, :last_name, :string
    remove_column :people, :ideal_pet
    remove_column :people, :lifestyle_fit
    remove_column :people, :activities
    remove_column :people, :alone_weekday
    remove_column :people, :alone_weekend
    remove_column :people, :experience
    remove_column :people, :contingency_plan
    remove_column :people, :shared_ownership
    remove_column :people, :shared_owner
    remove_column :people, :housing_type
    remove_column :people, :fenced_access
    remove_column :people, :fenced_alternative
    remove_column :people, :location_day
    remove_column :people, :location_night
    remove_column :people, :do_you_rent
    remove_column :people, :pets_allowed
    remove_column :people, :adults_in_home
    remove_column :people, :kids_in_home
    remove_column :people, :other_pets
    remove_column :people, :describe_pets
    remove_column :people, :checked_shelter
    remove_column :people, :surrendered_pet
    remove_column :people, :describe_surrender
    remove_column :people, :annual_cost
    remove_column :people, :visit_laventana
    remove_column :people, :visit_dates
  end
end
