require "test_helper"

class Organizations::AdoptionApplicationReviewsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user, :verified_staff)
    set_organization(@user.organization)
    sign_in @user
  end

  teardown do
    :after_teardown
  end

  test "should respond successfully" do
    get adoption_application_reviews_url
    assert_response :success
  end
end