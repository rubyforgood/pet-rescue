class AddNotNullToNameInTasks < ActiveRecord::Migration[7.0]
  def change
    change_column_null :tasks, :name, false
  end
end
