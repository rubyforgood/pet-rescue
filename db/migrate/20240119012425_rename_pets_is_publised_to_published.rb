class RenamePetsIsPublisedToPublished < ActiveRecord::Migration[7.0]
  def change
    rename_column :pets, :is_published, :published
  end
end
