class AddIsPublishedToPets < ActiveRecord::Migration[7.0]
  def change
    add_column :pets, :is_published, :boolean, default: true, null: false
  end
end
