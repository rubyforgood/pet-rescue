require "application_system_test_case"

class AdopterProfileFormsTest < ApplicationSystemTestCase
  test "visiting the adopter profile" do
    sign_in users(:user_one)
    visit edit_profile_path

    assert_selector "h1", text: "EDIT PROFILE"
  end
end
