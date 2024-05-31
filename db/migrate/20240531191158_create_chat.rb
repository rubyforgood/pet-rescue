class CreateChat < ActiveRecord::Migration[7.1]
  def change
    create_table :chats do |t|
      t.references :organization, index: true, null: false
      t.references :initiated_by, null: false
      t.date :initiated_on, index: true, null: false
      t.text :summary
      t.string :state

      t.timestamps
    end

    create_table :chat_participants do |t|
      t.references :chat, null: false, index: true
      t.references :user, null: false
      t.timestamp :last_seen, null: true
    end

    create_table :chat_pets do |t|
      t.references :chat, null: false, index: true
      t.references :pet, null: false, index: true
    end

    create_table :chat_messages do |t|
      t.references :chat, null: false
      t.references :author, null: false
      t.references :pet, null: true, index: true

      t.text :content, null: false

      t.timestamps
    end
  end
end
