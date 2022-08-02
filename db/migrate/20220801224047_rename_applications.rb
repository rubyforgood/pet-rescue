class RenameApplications < ActiveRecord::Migration[7.0]
  def change
    rename_table :applications, :adopter_applications
  end
end
