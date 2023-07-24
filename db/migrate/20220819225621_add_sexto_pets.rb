class AddSextoPets < ActiveRecord::Migration[7.0]
  def change
    add_column :pets, :sex, :string
  end
end
