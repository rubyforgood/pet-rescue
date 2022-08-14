class AddColumnsToAdopterProfiles < ActiveRecord::Migration[7.0]
  def change
    add_column :adopter_profiles, :phone_number, :string
    add_column :adopter_profiles, :contact_method, :string
    add_column :adopter_profiles, :country, :string
    add_column :adopter_profiles, :province_state, :string
    add_column :adopter_profiles, :city_town, :string
    add_column :adopter_profiles, :ideal_dog, :text
    add_column :adopter_profiles, :lifestyle_fit, :text
    add_column :adopter_profiles, :activities, :text
    add_column :adopter_profiles, :alone_weekday, :integer
    add_column :adopter_profiles, :alone_weekend, :integer
    add_column :adopter_profiles, :experience, :text
    add_column :adopter_profiles, :contingency_plan, :text
    add_column :adopter_profiles, :shared_ownership, :boolean
    add_column :adopter_profiles, :shared_owner, :text
    add_column :adopter_profiles, :housing_type, :string
    add_column :adopter_profiles, :fenced_access, :boolean
    add_column :adopter_profiles, :fenced_alternative, :text
    add_column :adopter_profiles, :location_day, :text
    add_column :adopter_profiles, :location_night, :text
    add_column :adopter_profiles, :do_you_rent, :boolean
    add_column :adopter_profiles, :dogs_allowed, :boolean
    add_column :adopter_profiles, :adults_in_home, :integer
    add_column :adopter_profiles, :kids_in_home, :integer
    add_column :adopter_profiles, :other_pets, :boolean
    add_column :adopter_profiles, :describe_pets, :text
    add_column :adopter_profiles, :checked_shelter, :boolean
    add_column :adopter_profiles, :surrendered_pet, :boolean
    add_column :adopter_profiles, :describe_surrender, :text
    add_column :adopter_profiles, :annual_cost, :string
  end
end
