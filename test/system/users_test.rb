require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  setup do
    @organization = create(:organization)
    @user = create(:user, organization: @organization)
    StaffAccount.create!(user: @user, organization: @organization, verified: true)
    set_organization(@organization)
  end

  test "user can log out" do
    visit root_url
    click_on "Log In"

    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password
    click_on "Log in"

    assert current_path.include?(@user.organization.slug)
    assert_equal current_path, dashboard_index_path

    using_wait_time(5) do
      find("#dropdownUser").hover
    end

    click_on "Sign Out"

    assert_text "Signed out successfully"
  end

  test "non-authenticated user attempts to log out" do
    visit root_url
    refute has_button?("Sign out")
    assert_equal current_path, root_path
    assert_text "Rescue a really cute pet and be a hero"
  end
end
