require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "should get new with dashboard layout when signed in as staff" do
    user = create(:user, :verified_staff)
    organization = user.staff_account.organization
    sign_in user

    get edit_user_registration_url(script_name: "/#{organization.slug}")
    assert_select "nav.navbar-vertical", 1
  end

  test "should get new with application layout when signed in but not staff" do
    user = create(:user)
    organization = create(:organization)
    sign_in user

    get edit_user_registration_url(script_name: "/#{organization.slug}")
    assert_select "nav.navbar-vertical", 0
  end
end
