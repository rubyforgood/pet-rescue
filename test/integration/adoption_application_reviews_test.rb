require "test_helper"

class AdoptionApplicationReviewsTest < ActionDispatch::IntegrationTest

  setup do
    @adopter_application = adopter_applications(:adopter_application_two)
    @adopter = @adopter_application.adopter_account.user
    @dog = dogs(:pending_adoption_two)
    @adopter_account_id = adopter_accounts(:adopter_account_one).id
  end

  test "verified staff can see all applications" do
    sign_in users(:verified_staff_one)

    get '/adopter_applications'

    assert_response :success
    assert_select 'a', {
      count: Dog.org_dogs_with_apps(users(:verified_staff_one).staff_account.organization_id).count, text: 'Adopter Profile'
    }
  end

  test "unverified staff cannot access the page" do
    sign_in users(:unverified_staff)

    get '/adopter_applications'

    assert_response :redirect
    follow_redirect!
    assert_equal 'Unauthorized action.', flash[:alert]
  end

  test "all expected elements of an application are shown" do
    sign_in users(:verified_staff_one)

    get '/adopter_applications'

    assert_select 'a', @adopter_application.dog.name
    assert_select 'p', "Applicant: #{@adopter.first_name}
                      #{@adopter.last_name}"
    assert_select 'a', 'Adopter Profile'
    assert_select 'a', 'Edit Application'
  end

  test "verified staff can edit an adoption application status" do
    sign_in users(:verified_staff_one)

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
    sign_in users(:unverified_staff)

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
    sign_in users(:verified_staff_one)

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
    sign_in users(:unverified_staff)

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
    sign_in users(:verified_staff_one)

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
    sign_in users(:verified_staff_one)

    get '/adopter_applications'

    assert_select 'a', {
      count: 1, text: @dog.name
    }

    post '/create_adoption',
      params: { adopter_account_id: @adopter_account_id, dog_id: @dog.id }

    assert_equal 'Dog successfully adopted.', flash[:notice]

    get '/adopter_applications'

    assert_select 'a', {
      count: 0, text: @dog.name
    }
  end

  test "after making the http request to create an adoption, a new Adoption is created" do
    sign_in users(:verified_staff_one)

    assert_changes 'Adoption.count', from: 1, to: 2 do
      post '/create_adoption',
        params: { adopter_account_id: @adopter_account_id, dog_id: @dog.id }
    end
  end

  test "Staff can revert withdraw and remove by an adopter and the application reappears for adopter" do
    sign_in users(:adopter_with_profile)

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

    sign_in users(:verified_staff_one)

    patch "/adopter_applications/#{@adopter_application.id}",
      params: { adopter_application:
        {
          status: 'under_review', notes: '', profile_show: 'true'
        }, commit: 'Save', id: @adopter_application.id
      }

    sign_in users(:adopter_with_profile)

    get '/my_applications'

    assert_select 'h3', {
      count: 1, text: @dog.name
    }
  end

  test "unverified staff cannot create an adoption" do
    sign_in users(:unverified_staff)

    post '/create_adoption',
      params: { adopter_account_id: @adopter_account_id, dog_id: @dog.id }

    assert_response :redirect
    follow_redirect!
    assert_equal 'Unauthorized action.', flash[:alert]
  end

  test "the filter works to show applications for a given dog and for all dogs" do 
    sign_in users(:verified_staff_one)

    get '/adopter_applications'
    assert_select 'div.card',
      # count of all unadopted dogs with an application for a given org
      { count: Dog.org_dogs_with_apps(users(:verified_staff_one).staff_account.organization_id).count }

    get '/adopter_applications',
      params: {dog_id: dogs(:pending_adoption_one).id }
    
    assert_select 'div.card', { count: 1 }
    assert_select 'h4', "#{dogs(:pending_adoption_one).name}"

    get '/adopter_applications',
      params: { dog_id: "" }
    
    assert_select 'div.card',
    { count: Dog.org_dogs_with_apps(users(:verified_staff_one).staff_account.organization_id).count }
  end
end
