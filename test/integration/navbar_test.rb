require "test_helper"

class NavbarTest < ActionDispatch::IntegrationTest
  test "unauthenticated users see create account and log in links and no dashboard" do
    get "/"
    assert_select "a", "Adopt"
    assert_select "a", "Log In"
    assert_select "a", {count: 0, text: "Pet Rescue"}
  end

  test "authenticated user sees log out button" do
    sign_in create(:user, :adopter_with_profile)
    get "/"
    assert_select "form" do
      assert_select "button", "Log Out"
    end
  end

  test "authenticated adopter without profile does not see Applications link" do
    sign_in create(:user, :adopter_without_profile)
    get "/"
    assert_select "a", "Pet Rescue"
    assert_select "a", "Account Settings"
    assert_select "a", "My Profile"
    assert_select "a", {count: 0, text: "My Applications"}
    assert_select "a", {count: 0, text: "Our Pets"}
    assert_select "a", {count: 0, text: "Applications"}
  end

  test "authenticated adopter without profile is directed to new profile by My Profile link" do
    sign_in create(:user, :adopter_without_profile)
    get "/"
    assert_select "a", "Pet Rescue"
    assert_select "a", "Account Settings"
    assert_select "a[href=?]", new_profile_path, {text: "My Profile"}
  end

  test "authenticated adopter with profile sees My Applications link" do
    sign_in create(:user, :adopter_with_profile)
    get "/"
    assert_select "a", "Pet Rescue"
    assert_select "a", "Account Settings"
    assert_select "a", "My Profile"
    assert_select "a", "My Applications"
    assert_select "a", {count: 0, text: "Our Pets"}
    assert_select "a", {count: 0, text: "Applications"}
  end

  test "authenticated staff sees dashboard with Our Pets and Applications links" do
    sign_in create(:user, :verified_staff)
    get "/"
    assert_select "a", "Pet Rescue"
    assert_select "a", "Account Settings"
    assert_select "a", "Our Pets"
    assert_select "a", "Applications"
    assert_select "a", {count: 0, text: "My Applications"}
    assert_select "a", {count: 0, text: "My Profile"}
  end
end
