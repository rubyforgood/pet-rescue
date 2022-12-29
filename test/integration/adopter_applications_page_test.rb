require "test_helper"

class AdopterApplicationsPageTest < ActionDispatch::IntegrationTest

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
    assert_select 'div.row', { count: 2 }
  end

end
