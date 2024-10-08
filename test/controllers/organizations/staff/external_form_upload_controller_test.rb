require "test_helper"

class Organizations::Staff::ExternalFormUploadControllerTest < ActionDispatch::IntegrationTest
  setup do
    file = fixture_file_upload("google_form_sample.csv", "text/csv")
    @params = {files: [file]}
    user = create(:admin)
    @user2 = create(:adopter, email: "adopter1@alta.com")
    sign_in user
  end

  test "Import from google_form_sample.csv creates FormAnswers" do
    assert_difference "FormAnswer.count", 4 do
      post staff_external_form_upload_index_path, params: @params
    end
    # No Form Answer is created when there is already existing Form submition with the csv_timestamp
    assert_no_difference "FormAnswer.count" do
      post staff_external_form_upload_index_path, params: @params
    end
  end
end
