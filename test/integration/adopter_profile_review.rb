require "test_helper"

class AdopterProfileReviewTest < ActionDispatch::IntegrationTest

  setup do
    @adopter_profile = adopter_profiles(:adopter_profile_one)
  end

  test "Verified staff can access an adopter profile" do
    sign_in users(:verified_staff_one)

    get "/profile_review/#{@adopter_profile.id}"

    assert_response :success
    assert_select 'h1', "#{users(:adopter_with_profile).first_name}
        #{users(:adopter_with_profile).last_name}'s Profile"
  end

  test "unverified staff cannot access an adopter profile" do
    sign_in users(:unverified_staff)

    get "/profile_review/#{@adopter_profile.id}"

    assert_response :redirect
    assert_equal 'Unauthorized action.', flash[:alert]
  end
end
