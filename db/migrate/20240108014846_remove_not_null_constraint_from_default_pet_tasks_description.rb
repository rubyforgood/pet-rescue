class RemoveNotNullConstraintFromDefaultPetTasksDescription < ActiveRecord::Migration[7.0]
  def change
    change_column_null :default_pet_tasks, :description, true
  end
end
