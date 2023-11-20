class AddStatus2Pets < ActiveRecord::Migration[7.0]
  def change
    add_column :pets, :placement_type, :integer, null: false
  end
end
