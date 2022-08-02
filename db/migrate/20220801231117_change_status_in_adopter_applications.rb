class ChangeStatusInAdopterApplications < ActiveRecord::Migration[7.0]
  def change
    remove_column :adopter_applications, :status
    add_column :adopter_applications, :status, :integer, default: 0
  end
end
