class CreateCustomPages < ActiveRecord::Migration[7.0]
  def change
    create_table :custom_pages do |t|
      t.references :organization, null: false, foreign_key: true
      t.string :hero
      t.text :about

      t.timestamps
    end
  end
end
