require "test_helper"

class ChecklistItemTest < ActiveSupport::TestCase
  context "associations" do
    should have_many(:items).dependent(:destroy)
  end
end
