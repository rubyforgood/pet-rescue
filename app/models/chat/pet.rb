# == Schema Information
#
# Table name: chat_pets
#
#  id      :bigint           not null, primary key
#  chat_id :bigint           not null
#  pet_id  :bigint           not null
#
# Indexes
#
#  index_chat_pets_on_chat_id  (chat_id)
#  index_chat_pets_on_pet_id   (pet_id)
#
class Chat::Pet < ApplicationRecord
  belongs_to :chat
  belongs_to :pet, class_name: "::Pet"
end
