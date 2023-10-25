require "test_helper"

class Organizations::DeactivateActivateStaffTest < ActionDispatch::IntegrationTest
  test "staff admin can deactivate other staff" do
    admin = create(:user, :staff_admin)
    set_organization(admin.organization)
    sign_in admin
    staff = create(:staff_account)

    post(staff_deactivate_url(staff.id))

    assert_response :redirect
    assert staff.reload.deactivated_at
  end

  test "staff admin can activate deactivated staff" do
    admin = create(:user, :staff_admin)
    set_organization(admin.organization)
    sign_in admin
    staff = create(:staff_account, deactivated_at: Time.now)

    post(staff_activate_url(staff.id))

    assert_response :redirect
    assert_nil staff.reload.deactivated_at
  end

  test "staff admin cannot deactivate himself" do
    admin = create(:user, :staff_admin)
    set_organization(admin.organization)
    sign_in admin

    post(staff_deactivate_url(admin.staff_account.id))

    assert_response :redirect
    assert_not admin.staff_account.reload.deactivated_at
  end
end
