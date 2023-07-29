# == Schema Information
#
# Table name: messages
#
#  id                     :bigint           not null, primary key
#  message                :string           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  adopter_application_id :integer          not null
#  sender_id              :integer          not null
#
# Foreign Keys
#
#  fk_rails_...  (adopter_application_id => adopter_applications.id)
#  fk_rails_...  (sender_id => users.id)
#
class Message < ApplicationRecord
  belongs_to :sender, class_name: "User"

  validates :message, presence: true

end
