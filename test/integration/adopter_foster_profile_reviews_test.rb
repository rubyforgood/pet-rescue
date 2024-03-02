require "test_helper"

class AdopterFosterProfileReviewTest < ActionDispatch::IntegrationTest
  test "Verified staff can access an adopter profile" do
    skip("while new ui is implemented")
    # first_name = "Bob"
    # last_name = "Bobberson"
    # staff_user = create(:user, :verified_staff)
    # adopter_user = create(:user, :adopter_with_profile, first_name: first_name, last_name: last_name)
    # sign_in staff_user

    # get "/profile_reviews/#{adopter_user.adopter_account.adopter_foster_profile.id}"

    # assert_response :success
    # assert_select "h1", "#{first_name} #{last_name}'s Profile"
  end

  test "deactivated staff cannot access an adopter profile" do
    staff_user = create(:user, :deactivated_staff)
    adopter_user = create(:user, :adopter_with_profile)
    sign_in staff_user

    get "/profile_reviews/#{adopter_user.adopter_account.adopter_foster_profile.id}"

    assert_response :redirect
    assert_equal "Your account is deactivated.", flash[:alert]
  end
end
