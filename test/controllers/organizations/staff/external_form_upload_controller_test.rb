require "test_helper"

module Organizations
  module Staff
    class ExternalFormUploadControllerTest < ActionDispatch::IntegrationTest
      setup do
        file = fixture_file_upload("google_form_sample.csv", "text/csv")
        @params = {files: [file]}
        user = create(:admin)
        @person = create(:adopter, email: "adopter1111@alta.com")
        @person2 = create(:adopter, email: "no_answer_will_be_created@alta.com")
        sign_in user
      end

      test "Creates form answers for person in its latest form submission" do
        assert_changes -> { @person.latest_form_submission.form_answers.count } do
          post staff_external_form_upload_index_path, params: @params
        end
      end

      test "It does not create form answers for person2" do
        assert_no_difference -> { @person2.latest_form_submission.form_answers.count } do
          post staff_external_form_upload_index_path, params: @params
        end
      end
    end
  end
end
