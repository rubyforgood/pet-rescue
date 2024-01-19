class ChangePetsPublishedDefault < ActiveRecord::Migration[7.0]
  def change
    change_column_default(:pets, :is_published, false)
  end
end
