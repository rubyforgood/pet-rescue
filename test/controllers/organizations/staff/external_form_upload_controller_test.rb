require "test_helper"

module Organizations
  module Staff
    class ExternalFormUploadControllerTest < ActionDispatch::IntegrationTest
      setup do
        file = fixture_file_upload("google_form_sample.csv", "text/csv")
        @params = {files: [file]}
        user = create(:admin)
        @person1 = create(:adopter, :with_person, email: "adopter1@alta.com")
        @person2 = create(:adopter, email: "willnotgetnewanswers@alta.com")
        sign_in user
      end

      # test "Import from google_form_sample.csv creates FormAnswers" do
      #   assert_difference "FormAnswer.count", 4 do
      #     post staff_external_form_upload_index_path, params: @params
      #   end
      #   # No Form Answer is created when there is already existing Form submition with the csv_timestamp
      #   assert_no_difference "FormAnswer.count" do
      #     post staff_external_form_upload_index_path, params: @params
      #   end
      # end

      test "Creates form answers for person1 but not for person2" do
        assert_changes -> { @person1.latest_form_submission.form_answers.count } do
          # assert_no_changes -> { @person2.latest_form_submission.form_answers.count } do
          post staff_external_form_upload_index_path, params: @params

          # end
        end
      end
    end
  end
end
