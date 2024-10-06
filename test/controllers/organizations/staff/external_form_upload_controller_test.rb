require "test_helper"

class Organizations::Staff::ExternalFormUploadControllerTest < ActionDispatch::IntegrationTest
  setup do
    @organization = ActsAsTenant.current_tenant
    @file = fixture_file_upload('google_form_sample.csv', 'text/csv')
    @params = { files: [@file] }
    @user = create(:admin, email: "adopter1@alta.com")
    @user2 = create(:admin)
    sign_in @user
  end

  test "Import from google_form_sample.csv" do
    #FomAnswers and FormSubmissions should be created
    assert_difference 'FormAnswer.count', 4 do
      assert_difference 'FormSubmission.count', 1 do
        post staff_external_form_upload_index_path, params: @params
      end
    end
    #There should be a form submission for @user but not for @user2
    assert FormSubmission.where(person_id: @user2.id).empty?
    refute FormSubmission.where(person_id: @user.id).empty?
  end
end