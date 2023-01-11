require "test_helper"

class AdoptionApplicationReviewsTest < ActionDispatch::IntegrationTest

  test "verified staff can see all applications" do
    sign_in users(:user_two)

    get '/adopter_applications'

    assert_response :success
    assert_select 'a', {
      count: AdopterApplication.count, text: 'Edit Application'
    }
  end

  test "unverified staff cannot access the page" do
    sign_in users(:user_three)

    get '/adopter_applications'

    assert_response :redirect
  end
end
