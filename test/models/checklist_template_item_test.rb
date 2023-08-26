require "test_helper"

class ChecklistTemplateItemTest < ActiveSupport::TestCase
  context "associations" do
    should belong_to(:checklist_template)
  end

  context "validations" do
    should validate_presence_of(:name)
    should validate_presence_of(:expected_duration_days)
    should validate_numericality_of(:expected_duration_days).is_greater_than_or_equal_to(0)
  end
end
