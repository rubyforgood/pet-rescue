require "test_helper"

class CustomForm::SubmissionTest < ActiveSupport::TestCase
  setup do
    @submission = create(:submission)
  end

  context "self.retire_submissions" do
    context "when some submissions match pet_id and some do not" do
      setup do
        @selected_submissions = Array.new(3) {
          create(:submission, pet_id: @submission.pet_id)
        }
        @unselected_submissions = Array.new(2) {
          create(:submission)
        }
      end

      should "update status of matching submissions to :adoption_made" do
        CustomForm::Submission.retire_submissions(pet_id: @submission.pet_id)

        @selected_submissions.each do |submission|
          assert_equal "adoption_made", submission.reload.status
        end
      end

      should "not update status of mismatching submissions" do
        cached_statuses = @unselected_submissions.map(&:status)

        CustomForm::Submission.retire_submissions(pet_id: @submission.pet_id)

        current_statuses = @unselected_submissions.map do |submission|
          submission.reload.status
        end

        assert_equal cached_statuses, current_statuses
      end
    end
  end

  context "#withdraw" do
    should "update status to :withdrawn" do
      @submission.withdraw

      assert "withdrawn", @submission.status
    end
  end
end
