# == Schema Information
#
# Table name: chats
#
#  id              :bigint           not null, primary key
#  initiated_on    :date             not null
#  state           :string
#  summary         :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  initiated_by_id :bigint           not null
#  organization_id :bigint           not null
#
# Indexes
#
#  index_chats_on_initiated_by_id  (initiated_by_id)
#  index_chats_on_initiated_on     (initiated_on)
#  index_chats_on_organization_id  (organization_id)
#
class Chat < ApplicationRecord
  PROFILE_TYPES = %w[OrganizationProfile AdopterFosterProfile]

  acts_as_tenant(:organization)

  belongs_to :initiated_by, class_name: "User"
  has_many :messages, class_name: "Chat::Message"
  has_many :participants, class_name: "Chat::Participant"

  has_many :chat_pets, class_name: "Chat::Pet"
  has_many :pets, through: :chat_pets

  validates :organization, presence: true
  validates :initiated_on, presence: true
end
