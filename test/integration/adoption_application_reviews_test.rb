require "test_helper"

class AdoptionApplicationReviewsTest < ActionDispatch::IntegrationTest

  setup do
    @adopter_application = adopter_applications(:adopter_application_one)
    @adopter = @adopter_application.adopter_account.user
  end

  test "verified staff can see all applications" do
    sign_in users(:user_two)

    get '/adopter_applications'

    assert_response :success
    assert_select 'a', {
      count: Dog.org_dogs_with_apps(users(:user_two).staff_account.organization_id).count, text: 'Adopter Profile'
    }
  end

  test "unverified staff cannot access the page" do
    sign_in users(:user_three)

    get '/adopter_applications'

    assert_response :redirect
    follow_redirect!
    assert_equal 'Unauthorized action.', flash[:alert]
  end

  test "all expected elements of an application are shown" do
    sign_in users(:user_two)

    get '/adopter_applications'

    assert_select 'a', @adopter_application.dog.name
    assert_select 'p', "Applicant: #{@adopter.first_name}
                      #{@adopter.last_name}"
    assert_select 'a', 'Adopter Profile'
    assert_select 'a', 'Edit Application'
  end
end
