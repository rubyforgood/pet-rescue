class ChangeColumnName < ActiveRecord::Migration[7.0]
  def change
    rename_column :locations, :adopter_profile_id, :person_id
  end
end
