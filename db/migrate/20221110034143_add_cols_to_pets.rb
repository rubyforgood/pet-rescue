class AddColsToPets < ActiveRecord::Migration[7.0]
  def change
    add_column :pets, :application_paused, :boolean, default: false
    add_column :pets, :pause_reason, :integer, default: 0
  end
end
