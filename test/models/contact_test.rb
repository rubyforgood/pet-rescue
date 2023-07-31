require "test_helper"

class ContactTest < ActiveSupport::TestCase
  context "validations" do
    should validate_presence_of(:name)
    should validate_presence_of(:email)
    should validate_presence_of(:message)
  end
end
