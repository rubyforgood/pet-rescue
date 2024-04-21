class CreateFaqs < ActiveRecord::Migration[7.1]
  def change
    create_table :faqs do |t|
      t.string :question, null: false
      t.text :answer, null: false
      t.integer :order
      t.references :organization, null: false, foreign_key: true

      t.timestamps
    end
  end
end
