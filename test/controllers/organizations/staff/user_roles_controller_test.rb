require "test_helper"
require "action_policy/test_helper"

class Organizations::Staff::UserRolesControllerTest < ActionDispatch::IntegrationTest
  context "authorization" do
    include ActionPolicy::TestHelper

    setup do
      @organization = ActsAsTenant.current_tenant
      user = create(:staff_admin)
      sign_in user
      @account = create(:staff)
    end

    context "#to_staff" do
      should "be authorized" do
        assert_authorized_to(
          :change_role?, @account,
          with: Organizations::UserRolesPolicy
        ) do
          post staff_user_to_staff_url(@account), headers: {"HTTP_REFERER" => "http://www.example.com/"}
        end
      end
    end

    context "#to_admin" do
      should "be authorized" do
        assert_authorized_to(
          :change_role?, @account,
          with: Organizations::UserRolesPolicy
        ) do
          post staff_user_to_admin_url(@account), headers: {"HTTP_REFERER" => "http://www.example.com/"}
        end
      end
    end
  end
  teardown do
    :after_teardown
  end

  context "#to_staff" do
    setup do
      @organization = ActsAsTenant.current_tenant
      @user = create(:staff_admin)
      @account = create(:staff_admin)
      # @staff = create(:staff)
      sign_in @user
    end

    should "change role from admin to staff" do
      post staff_user_to_staff_url(@account), headers: {"HTTP_REFERER" => "http://www.example.com/"}
      has_role = @account.has_role?(:staff, ActsAsTenant.current_tenant)

      assert_equal has_role, true
    end
    should "not allow user to change own role" do
      post staff_user_to_staff_url(@user), headers: {"HTTP_REFERER" => "http://www.example.com/"}

      has_role = @user.has_role?(:staff, ActsAsTenant.current_tenant)
      assert_equal has_role, false
    end
  end

  context "#to_admin" do
    setup do
      @organization = ActsAsTenant.current_tenant
      @user = create(:staff_admin)
      @account = create(:staff_admin)
      sign_in @user
    end

    should "change role from staff to admin" do
      post staff_user_to_admin_url(@account), headers: {"HTTP_REFERER" => "http://www.example.com/"}
      has_role = @account.has_role?(:admin, ActsAsTenant.current_tenant)

      assert_equal has_role, true
    end
  end
end
