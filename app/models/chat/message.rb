# == Schema Information
#
# Table name: chat_messages
#
#  id         :bigint           not null, primary key
#  content    :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  author_id  :bigint           not null
#  chat_id    :bigint           not null
#  pet_id     :bigint
#
# Indexes
#
#  index_chat_messages_on_author_id  (author_id)
#  index_chat_messages_on_chat_id    (chat_id)
#  index_chat_messages_on_pet_id     (pet_id)
#
class Chat
  class Message < ApplicationRecord
    belongs_to :chat, required: true
    belongs_to :author, required: true, class_name: "User"

    validates :content, presence: true
  end
end
