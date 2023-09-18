require "test_helper"

class ChecklistTemplateItemTest < ActiveSupport::TestCase
  context "associations" do
    should belong_to(:checklist_template)
  end

  context "validations" do
    should validate_presence_of(:name)
    should validate_presence_of(:expected_duration_days)
  end
end
