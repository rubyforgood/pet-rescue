require "test_helper"

class ChatTest < ActiveSupport::TestCase
  context "associations" do
    should belong_to(:initiated_by).class_name("User")
    should have_many(:messages).class_name("Chat::Message")
    should have_many(:chat_pets).class_name("Chat::Pet")
    should have_many(:pets).through(:chat_pets)
    should have_many(:participants).class_name("Chat::Participant")
  end

  context "validations" do
    should validate_presence_of(:initiated_on)
  end
end
