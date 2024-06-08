require "test_helper"

class Organizations::InviteStaffTest < ActionDispatch::IntegrationTest
  setup do
    user = create(:staff_admin)
    sign_in user

    @user_invitation_params = {
      user: {
        first_name: "John",
        last_name: "Doe",
        email: "john@example.com",
        roles: "admin"
      }
    }
    admin = create(:staff_admin)
    sign_in admin
  end

  test "staff admin can invite other staffs to the organization" do
    post(
      user_invitation_path,
      params: @user_invitation_params
    )

    assert_response :redirect

    invited_user = User.find_by(email: "john@example.com")

    assert invited_user.invited_to_sign_up?
    assert invited_user.has_role?(:admin, invited_user.organization)
    assert_not invited_user.staff_account.deactivated?

    assert_equal 1, ActionMailer::Base.deliveries.count
  end

  test "staff admin can not invite existing user to the organization" do
    _existing_user = create(:user, email: "john@example.com")

    post(
      user_invitation_path,
      params: @user_invitation_params
    )

    assert_response :unprocessable_entity
  end
end
