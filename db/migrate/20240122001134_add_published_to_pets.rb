class AddPublishedToPets < ActiveRecord::Migration[7.0]
  def change
    add_column :pets, :published, :boolean, default: false, null: false
  end
end
