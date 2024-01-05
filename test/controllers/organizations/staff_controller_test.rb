require "test_helper"

class Organizations::StaffControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user, :staff_admin)
    set_organization(@user.organization)
    @staff = create(:staff_account)
    sign_in @user
  end

  teardown do
    :after_teardown
  end

  test "update activation should respond with turbo_stream when toggled on staff page" do
    post staff_update_activation_url(@staff), as: :turbo_stream

    assert_equal Mime[:turbo_stream], response.media_type
    assert_response :success
  end
end