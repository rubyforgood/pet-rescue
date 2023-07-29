class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.integer :sender_id, null: false
      t.integer :adopter_application_id, null: false
      t.string :message, null: false

      t.timestamps
    end

    add_foreign_key :messages, :users, column: :sender_id
    add_foreign_key :messages, :adopter_applications, column: :adopter_application_id
  end
end
