class RemovePauseReasonFromPets < ActiveRecord::Migration[7.0]
  def change
    remove_column :pets, :pause_reason, :integer
  end
end
