require "test_helper"

class OrganizationProfileTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  context "associations" do
    should belong_to(:organization)
    should belong_to(:location)
  end
end
