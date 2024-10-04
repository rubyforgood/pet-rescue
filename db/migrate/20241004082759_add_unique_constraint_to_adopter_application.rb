class AddUniqueConstraintToAdopterApplication < ActiveRecord::Migration[7.1]
  def change
    safety_assured do
      add_index :adopter_applications, [:pet_id, :form_submission_id], unique: true
    end
  end
end
