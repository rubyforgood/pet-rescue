require "test_helper"

class AdopterApplicationTest < ActiveSupport::TestCase
  setup do
    @form_submission = create(:form_submission)
    @application = create(:adopter_application, form_submission: @form_submission)
  end

  context "associations" do
    should belong_to(:pet).touch(true)
    should belong_to(:form_submission)
  end

  context "self.retire_applications" do
    context "when some applications match pet_id and some do not" do
      setup do
        @selected_applications = Array.new(3) {
          create(:adopter_application, pet_id: @application.pet_id, form_submission: @form_submission)
        }
        @unselected_applications = Array.new(2) {
          create(:adopter_application, form_submission: @form_submission)
        }
      end

      should "update status of matching applications to :adoption_made" do
        AdopterApplication.retire_applications(pet_id: @application.pet_id)

        @selected_applications.each do |application|
          assert_equal "adoption_made", application.reload.status
        end
      end

      should "not update status of mismatching applications" do
        cached_statuses = @unselected_applications.map(&:status)

        AdopterApplication.retire_applications(pet_id: @application.pet_id)

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
