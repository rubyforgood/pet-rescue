require "test_helper"

class CustomPageTest < ActiveSupport::TestCase
  context "validations" do
    should validate_presence_of(:hero).allow_nil
    should validate_presence_of(:about).allow_nil
  end
end
