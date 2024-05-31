require "test_helper"

class Chat::PetTest < ActiveSupport::TestCase
  context "associations" do
    should belong_to(:chat)
    should belong_to(:pet)
  end
end
