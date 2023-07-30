require "test_helper"

class ChecklistAssignmentTest < ActiveSupport::TestCase
  test "assigning checklist to match" do
    match = matches(:adoption_one)
    checklist = checklist_templates(:one)

    match.assign_checklist_template(checklist)

    assert_equal checklist.items.count, match.checklist_assignments.count
  end

  # test "assignment completion" do
  #   # match = matches(:adoption_one)

  #   # assert match.checklist_assignments.none? {|assignment|assignment.completed?}
  #   # assert_difference( "ChecklistAssignment.completed.count", -1) do 
  #   #   ChecklistAssignment.first.update!(completed_at: Time.now)
  #   # end 
  # end
end

