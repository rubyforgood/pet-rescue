class RemoveAdopterApplicationIdFromAdoptions < ActiveRecord::Migration[7.0]
  def change
    remove_column :adoptions, :adopter_application_id, :bigint
  end
end
