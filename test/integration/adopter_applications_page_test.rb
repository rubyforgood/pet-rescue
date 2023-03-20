require "test_helper"

class AdopterApplicationsPageTest < ActionDispatch::IntegrationTest

  setup do
    @application_id = adopter_applications(:adopter_application_one).id
  end

  test "Adopter without profile cannot access adopter applications route" do
    sign_in users(:user_four)

    get '/my_applications'

    assert_response :redirect
    follow_redirect!
    assert_equal 'Unauthorized action.', flash[:alert]
  end

  test "Adopter with profile can access adopter applications route and see applications" do
    sign_in users(:user_one)

    get '/my_applications'

    assert_response :success
    assert_select 'h1', 'Adoption Applications'

    # two Withdraw buttons and one navbar logout button
    visible_applications_count = users(:user_one)
                                .adopter_account
                                .adopter_applications
                                .where.not(status: ['adoption_made'])
                                .where(profile_show: true)
                                .count
    assert_select 'form', { count: visible_applications_count + 1 }
    assert_select 'form' do
      assert_select 'button', 'Withdraw'
    end
    assert_select 'h3', 'AppTest'
  end

  test "Adopter with account can withdraw an application and see remove button" do
    sign_in users(:user_one)

    patch '/my_application',
    params: { application:
      {
        id: @application_id,
        status: 'withdrawn'
      }
    }

    assert_response :redirect
    follow_redirect!
    assert_select 'h1', 'Adoption Applications'

    # two Withdraw buttons and one navbar logout button
    visible_applications_count = users(:user_one)
                                .adopter_account
                                .adopter_applications
                                .where.not(status: ['adoption_made'])
                                .where(profile_show: true)
                                .count
    assert_select 'form', { count: visible_applications_count + 1 }
    assert_select 'form' do
      assert_select 'button', 'Withdraw'
    end
    assert_select 'form' do
      assert_select 'button', 'Remove'
    end
  end

  test "Adopter with account can remove an application from the page" do
    sign_in users(:user_one)

    patch '/my_application',
    params: { application:
      {
        id: @application_id,
        profile_show: 'false'
      }
    }

    assert_response :redirect
    follow_redirect!

    assert_select 'h1', 'Adoption Applications'

    # One Withdraw button and one navbar logout button
    visible_applications_count = users(:user_one)
                                .adopter_account
                                .adopter_applications
                                .where.not(status: ['adoption_made'])
                                .where(profile_show: true)
                                .count
    assert_select 'form', { count: visible_applications_count + 1 }
    assert_select 'form' do
      assert_select 'button', 'Withdraw'
    end
  end

  test "Adoption status changes when staff change the application status" do
    sign_in users(:user_one)

    get '/my_applications'
    assert_response :success
    assert_select 'p', 'Status: Awaiting Review'

    logout
    sign_in users(:user_two)

    patch "/adopter_applications/#{@application_id}",
    params: { adopter_application:
      {
        status: 'adoption_pending'
      }
    }

    logout
    sign_in users(:user_one)

    get '/my_applications'
    assert_response :success
    assert_select 'p', 'Status: Adoption Pending'
  end

  test "Staff can revert withdraw and remove by an adopter and the application reappears for adopter" do
    sign_in users(:user_one)

    get '/my_applications'
    assert_response :success
    visible_applications_count = users(:user_one)
                                .adopter_account
                                .adopter_applications
                                .where.not(status: ['adoption_made'])
                                .where(profile_show: true)
                                .count
    assert_select 'form', { count: visible_applications_count + 1 }

    # withdraw and remove in one request
    patch '/my_application',
    params: { application:
      {
        id: @application_id,
        status: 'withdrawn',
        profile_show: false
      }
    }

    assert_response :redirect
    follow_redirect!
    visible_applications_count = users(:user_one)
                                .adopter_account
                                .adopter_applications
                                .where.not(status: ['adoption_made'])
                                .where(profile_show: true)
                                .count
    assert_select 'form', { count: visible_applications_count + 1 }
    logout

    sign_in users(:user_two)
    patch "/adopter_applications/#{@application_id}",
    params: { adopter_application:
      {
        status: 'adoption_pending',
        profile_show: 'true'
      }
    }

    logout
    sign_in users(:user_one)
    get '/my_applications'
    assert_response :success
    visible_applications_count = users(:user_one)
                                .adopter_account
                                .adopter_applications
                                .where.not(status: ['adoption_made'])
                                .where(profile_show: true)
                                .count
    assert_select 'form', { count: visible_applications_count + 1 }
  end
end
