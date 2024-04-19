require "test_helper"

class FaqTest < ActiveSupport::TestCase
  context "validations" do
    should validate_presence_of(:question)
    should validate_presence_of(:answer)
  end
end
