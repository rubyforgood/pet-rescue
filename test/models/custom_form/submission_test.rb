require "test_helper"

class CustomForm::SubmissionTest < ActiveSupport::TestCase
  setup do
    @application = create(:submission)
  end

  context "self.retire_applications" do
    context "when some applications match pet_id and some do not" do
      setup do
        @selected_applications = Array.new(3) {
          create(:submission, pet_id: @application.pet_id)
        }
        @unselected_applications = Array.new(2) {
          create(:submission)
        }
      end

      should "update status of matching applications to :adoption_made" do
        CustomForm::Submission.retire_applications(pet_id: @application.pet_id)

        @selected_applications.each do |application|
          assert_equal "adoption_made", application.reload.status
        end
      end

      should "not update status of mismatching applications" do
        cached_statuses = @unselected_applications.map(&:status)

        CustomForm::Submission.retire_applications(pet_id: @application.pet_id)

        current_statuses = @unselected_applications.map do |application|
          application.reload.status
        end

        assert_equal cached_statuses, current_statuses
      end
    end
  end

  context "#withdraw" do
    should "update status to :withdrawn" do
      @application.withdraw

      assert "withdrawn", @application.status
    end
  end
end
