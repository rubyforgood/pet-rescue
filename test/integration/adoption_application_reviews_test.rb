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

  test "all expected elements of an application are shown" do
    sign_in users(:user_two)

    get '/adopter_applications'

    assert_select 'a', AdopterApplication.first.dog.name
    assert_select 'p', "Applicant: #{AdopterApplication.first.adopter_account.user.first_name}
                      #{AdopterApplication.first.adopter_account.user.last_name}"
    assert_select 'a', 'Adopter Profile'
    assert_select 'a', 'Edit Application'
  end
end
