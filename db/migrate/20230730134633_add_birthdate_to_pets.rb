class AddBirthdateToPets < ActiveRecord::Migration[7.0]
  def change
    add_column :pets, :birth_date, :datetime, null: false
  end
end
