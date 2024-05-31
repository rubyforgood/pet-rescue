require "test_helper"

class Chat::MessageTest < ActiveSupport::TestCase
  context "associations" do
    should belong_to(:chat)
    should belong_to(:author).class_name("User")
  end

  context "validations" do
    should validate_presence_of(:content)
  end
end
