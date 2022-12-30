require "test_helper"

class AdopterApplicationsPageTest < ActionDispatch::IntegrationTest

  setup do
    @application_id = AdopterApplication.first.id
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
    assert_select 'form', { count: 3 }
    assert_select 'form' do
      assert_select 'button', 'Withdraw'
    end
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
    assert_select 'form', { count: 3 }
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
    assert_select 'form', { count: 2 }
    assert_select 'form' do
      assert_select 'button', 'Withdraw'
    end
  end

  test "Adoption status changes when staff change the application status" do
    # log in as adopter and check status is awaiting review
    # log out
    # log in as staff and change status to under review
    # log our
    # log in as adopter and check status is under review
  end
end
