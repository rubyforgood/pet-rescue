require "application_system_test_case"

class LoginTest < ApplicationSystemTestCase
  setup do
    @organization = create(:organization)
    @user = create(:user, organization: @organization)
    StaffAccount.create!(user: @user, organization: @organization, verified: true)
    set_organization(@organization)
  end

  context "when logging in as a staff member" do
    should "direct to the organization's dashboard" do
      visit root_url
      click_on "Log In"

      fill_in "Email", with: @user.email
      fill_in "Password", with: @user.password
      click_on "Log in"

      assert current_path.include?(@user.organization.slug)
      assert current_path.has_content?("Dashboard")
    end
  end
end
