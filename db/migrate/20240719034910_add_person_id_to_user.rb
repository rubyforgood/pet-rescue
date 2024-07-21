class AddPersonIdToUser < ActiveRecord::Migration[7.1]
  def change
    change_table :users do |t|
      t.references :person, foreign_key: true
    end
  end
end
