class AddColumnToAdopterApplications < ActiveRecord::Migration[7.0]
  def change
    add_column :adopter_applications, :profile_show, :boolean, default: true
  end
end
