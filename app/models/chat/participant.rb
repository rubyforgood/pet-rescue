# == Schema Information
#
# Table name: chat_participants
#
#  id        :bigint           not null, primary key
#  last_seen :datetime
#  chat_id   :bigint           not null
#  user_id   :bigint           not null
#
# Indexes
#
#  index_chat_participants_on_chat_id  (chat_id)
#  index_chat_participants_on_user_id  (user_id)
#
class Chat
  class Participant < ApplicationRecord
    belongs_to :chat, required: true
    belongs_to :user, required: true
  end
end
