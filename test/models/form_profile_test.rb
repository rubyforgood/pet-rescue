require "test_helper"

class FormProfileTest < ActiveSupport::TestCase
  context "associations" do
    should belong_to(:form)

    should have_one(:organization).through(:form)
  end
end
