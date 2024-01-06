class RemovePauseReasonFromPets < ActiveRecord::Migration[7.0]
  def change
    safety_assured do
      remove_column :pets, :pause_reason, :integer
    end
  end
end
