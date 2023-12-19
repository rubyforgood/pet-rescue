class AddNotNullToNameInTasks < ActiveRecord::Migration[7.0]
  def change
    safety_assured do
      change_column_null :tasks, :name, false
    end
  end
end
