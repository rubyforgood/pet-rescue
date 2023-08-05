require "test_helper"

class ChecklistAssignmentTest < ActiveSupport::TestCase
  test "assigning checklist to match" do
    organization = create(:organization)
    pet = create(:pet, :adopted, organization: organization)
    match = create(
      :match,
      adopter_account: create(:adopter_account),
      pet: pet,
      organization: organization
    )
    checklist = create(:checklist_template)

    match.assign_checklist_template(checklist)

    assert_equal checklist.items.count, match.checklist_assignments.count
  end

  test "assignment completion" do
    create(:checklist_assignment)

    assert_difference("ChecklistAssignment.incomplete.count", -1) do
      ChecklistAssignment.first.update!(completed_at: Time.now)
    end
  end
end
