class RenameAdoptionToMatch < ActiveRecord::Migration[7.0]
  def change
    rename_table :adoptions, :matches
  end
end
