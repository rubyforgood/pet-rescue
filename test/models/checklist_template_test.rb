require "test_helper"

class ChecklistTemplateTest < ActiveSupport::TestCase
  context "associations" do
    should have_many(:items).dependent(:destroy)
  end
end
