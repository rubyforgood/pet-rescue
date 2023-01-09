require "application_system_test_case"

class AdopterProfileFormsTest < ApplicationSystemTestCase
  test "Character counter displays after adding text to ideal dog input" do
    sign_in users(:user_one)
    visit profile_path

    click_on "Edit Profile"
    assert_selector "h1", text: "EDIT PROFILE"
    fill_in "Briefly describe your ideal dog", with: "Big and fluffy."
    assert_selector "div.small", text: "15/200"
  end
end
