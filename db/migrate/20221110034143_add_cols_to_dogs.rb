class AddColsToDogs < ActiveRecord::Migration[7.0]
  def change
    add_column :dogs, :application_paused, :boolean, default: false
    add_column :dogs, :pause_reason, :integer, default: 0
  end
end
