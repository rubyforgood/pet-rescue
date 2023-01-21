require "test_helper"

class AdoptionApplicationReviewsTest < ActionDispatch::IntegrationTest

  setup do
    @adopter_application = adopter_applications(:adopter_application_two)
    @adopter = @adopter_application.adopter_account.user
    @dog = dogs(:dog_five)
    @adopter_account_id = adopter_accounts(:adopter_account_one).id
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

  test "verified staff can edit an adoption application status" do
    sign_in users(:user_two)

    assert_changes 'AdopterApplication.find(@adopter_application.id).status', from: 'awaiting_review', to: 'under_review' do
      put "/adopter_applications/#{@adopter_application.id}",
        params: { adopter_application:
          {
            status: 'under_review', notes: ''
          }, commit: 'Save', id: @adopter_application.id
        }
    end
  end

  test "unverified staff cannot edit an adoption application status" do
    sign_in users(:user_three)

    put "/adopter_applications/#{@adopter_application.id}",
    params: { adopter_application:
      {
        status: 'under_review', notes: ''
      }, commit: 'Save', id: @adopter_application.id
    }

    assert_response :redirect
    follow_redirect!
    assert_equal 'Unauthorized action.', flash[:alert]
  end

  test "verified staff can add notes to an application" do
    sign_in users(:user_two)

    put "/adopter_applications/#{@adopter_application.id}",
      params: { adopter_application:
        {
          status: 'under_review', notes: 'some notes'
        }, commit: 'Save', id: @adopter_application.id
      }

    assert_response :redirect

    get "/adopter_applications/#{@adopter_application.id}/edit"

    assert_select 'textarea', 'some notes'
  end

  test "unverified staff cannot add notes to an application" do
    sign_in users(:user_three)

    put "/adopter_applications/#{@adopter_application.id}",
      params: { adopter_application:
        {
          status: 'under_review', notes: 'some notes'
        }, commit: 'Save', id: @adopter_application.id
      }

    assert_response :redirect
    follow_redirect!
    assert_equal 'Unauthorized action.', flash[:alert]
  end

  test "when Successful Applicant is selected, button to Create Adoption shows" do
    sign_in users(:user_two)

    put "/adopter_applications/#{@adopter_application.id}",
      params: { adopter_application:
        {
          status: 'successful_applicant', notes: ''
        }, commit: 'Save', id: @adopter_application.id
      }

    follow_redirect!
    assert_select 'a', 'Create Adoption'
  end

  test "after making the http request to create an adoption, the application disappears" do
    sign_in users(:user_two)

    put "/adopter_applications/#{@adopter_application.id}",
      params: { adopter_application:
        {
          status: 'successful_applicant', notes: ''
        }, commit: 'Save', id: @adopter_application.id
      }

    post '/create_adoption',
      params: { adopter_account_id: @adopter_account_id, dog_id: @dog.id }

    follow_redirect!
    assert_select 'a', {
      count: 0, text: @dog.name
    }
  end

  test "after making the http request to create an adoption, a new Adoption is created" do
    sign_in users(:user_two)

    assert_changes 'Adoption.count', from: 1, to: 2 do
      post '/create_adoption',
        params: { adopter_account_id: @adopter_account_id, dog_id: @dog.id }
    end
  end

  test "an adopter can withdraw and remove an application and a staff can subsequently set the adoption application from withdrawn to another status and the application reappears on the adopter's applications page" do
    sign_in users(:user_one)

    patch '/my_application',
      params: { application:
        {
          id: @adopter_application.id, status: 'withdrawn'
        }
      }

    patch '/my_application',
      params: { application:
        {
          id: @adopter_application.id, profile_show: 'false'
        }
      }

    assert_select 'h3', {
      count: 0, text: @dog.name
    }

    sign_in users(:user_two)

    patch "/adopter_applications/#{@adopter_application.id}",
      params: { adopter_application:
        {
          status: 'under_review', notes: '', profile_show: 'true'
        }, commit: 'Save', id: @adopter_application.id
      }

    sign_in users(:user_one)

    get '/my_applications'

    assert_select 'h3', {
      count: 1, text: @dog.name
    }
  end
end
