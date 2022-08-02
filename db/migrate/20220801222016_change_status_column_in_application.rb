class ChangeStatusColumnInApplication < ActiveRecord::Migration[7.0]
  def change
    remove_column :applications, :status
    add_column :applications, :status, :integer, default: 0, null: false
  end
end
