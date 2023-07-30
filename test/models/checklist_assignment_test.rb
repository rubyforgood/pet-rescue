require "test_helper"

class ChecklistAssignmentTest < ActiveSupport::TestCase
  test "assigning checklist to match" do
    match = Match.create!(
      adopter_account: adopter_accounts(:adopter_account_one),
      pet: pets(:adopted_pet)
    )
    checklist = checklist_templates(:one)

    match.assign_checklist_template(checklist)

    assert_equal checklist.items.count, match.checklist_assignments.count
  end

  test "assignment completion" do
    assert_difference("ChecklistAssignment.incomplete.count", -1) do
      ChecklistAssignment.first.update!(completed_at: Time.now)
    end
  end
end
