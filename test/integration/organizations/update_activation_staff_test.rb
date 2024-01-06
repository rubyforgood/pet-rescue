class Organizations::UpdateStaffActivationTest < ActionDispatch::IntegrationTest
  test "staff admin can deactivate other staff" do
    admin = create(:user, :staff_admin)
    set_organization(admin.organization)
    sign_in admin
    staff = create(:staff_account)

    post(staff_update_activation_url(staff.id))

    assert staff.reload.deactivated_at
  end

  test "staff admin can activate deactivated staff" do
    admin = create(:user, :staff_admin)
    set_organization(admin.organization)
    sign_in admin
    staff = create(:staff_account, :deactivated)

    post(staff_update_activation_url(staff.id))

    assert_nil staff.reload.deactivated_at
  end

  test "staff admin cannot deactivate himself" do
    admin = create(:user, :staff_admin)
    set_organization(admin.organization)
    sign_in admin

    post(staff_update_activation_url(admin.staff_account.id))

    assert_not admin.staff_account.reload.deactivated_at
  end
end
