class AddColsToAdopterProfile < ActiveRecord::Migration[7.0]
  def change
    add_column :adopter_profiles, :visit_laventana, :boolean
    add_column :adopter_profiles, :visit_dates, :text
    add_column :adopter_profiles, :referral_source, :text
  end
end
