require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  setup do
    @user = create(:staff)
    @organization = @user.organization
  end

  test "user can log out" do
    visit root_url
    click_on "Log In"

    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password
    click_on "Log in"

    assert current_path.include?(@organization.slug)
    assert has_current_path?(pets_path)

    using_wait_time(5) do
      find("#dropdownUser").hover
    end

    click_on "Sign Out"

    assert_text "Signed out successfully"
  end

  test "non-authenticated user attempts to log out" do
    visit root_url
    refute has_button?("Sign out")
    expected_path = "/" + @organization.slug + "/home"
    assert has_current_path?(expected_path)
    assert_text "Rescue a really cute pet and be a hero"
  end
end
