require "test_helper"

class Chat::ParticipantTest < ActiveSupport::TestCase
  context "associations" do
    should belong_to(:chat)
    should belong_to(:user)
  end
end
