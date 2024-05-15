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
          context: {organization: @organization},
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
          context: {organization: @organization},
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
      sign_in @user
    end

    should "change role from admin to staff" do
      post staff_user_to_staff_url(@account), headers: {"HTTP_REFERER" => "http://www.example.com/"}
      assert_response :redirect
      follow_redirect!

      assert_equal flash.notice, "Account changed to Staff"

      has_role = @account.has_role?(:staff, ActsAsTenant.current_tenant)
      assert_equal has_role, true
    end

    should "change role from admin to staff with turbo" do
      post staff_user_to_staff_url(@account), as: :turbo_stream

      assert_response :success
      assert_turbo_stream(action: "replace", count: 2) do
        assert_select "button", text: "Staff"
      end
      assert_equal flash.notice, "Account changed to Staff"
    end

    should "not allow user to change own role" do
      post staff_user_to_staff_url(@user), headers: {"HTTP_REFERER" => "http://www.example.com/"}

      has_role = @user.has_role?(:staff, ActsAsTenant.current_tenant)
      assert_equal has_role, false
    end

    should "scope role to organization" do
      post staff_user_to_staff_url(@account), headers: {"HTTP_REFERER" => "http://www.example.com/"}
      has_strict_role = @account.has_strict_role?(:staff, ActsAsTenant.current_tenant)
      global_role = @account.has_role?(:staff)

      assert_equal has_strict_role, true
      assert_equal global_role, false
    end

    should "receive alert if role is not changed" do
      Organizations::Staff::UserRolesController.any_instance.stubs(:change_role).returns(false)
      post staff_user_to_staff_url(@account), headers: {"HTTP_REFERER" => "http://www.example.com/"}

      assert_response :redirect
      follow_redirect!

      assert_equal flash.alert, "Error changing role"
    end

    should "receive alert via turbo if role is not changed" do
      Organizations::Staff::UserRolesController.any_instance.stubs(:change_role).returns(false)
      post staff_user_to_staff_url(@account), as: :turbo_stream

      assert_equal flash.alert, "Error changing role"
    end
  end

  context "#to_admin" do
    setup do
      @organization = ActsAsTenant.current_tenant
      @user = create(:staff_admin)
      @account = create(:staff)
      sign_in @user
    end

    should "change role from staff to admin" do
      post staff_user_to_admin_url(@account), headers: {"HTTP_REFERER" => "http://www.example.com/"}
      assert_response :redirect
      follow_redirect!

      assert_equal flash.notice, "Account changed to Admin"

      has_role = @account.has_role?(:admin, ActsAsTenant.current_tenant)
      assert_equal has_role, true
    end

    should "change role from staff to admin with turbo" do
      post staff_user_to_admin_url(@account), as: :turbo_stream

      assert_response :success
      assert_turbo_stream(action: "replace", count: 2) do
        assert_select "button", text: "Admin"
      end
      assert_equal flash.notice, "Account changed to Admin"
    end

    should "scope role to organization" do
      post staff_user_to_admin_url(@account), headers: {"HTTP_REFERER" => "http://www.example.com/"}
      has_strict_role = @account.has_strict_role?(:admin, ActsAsTenant.current_tenant)
      global_role = @account.has_role?(:admin)

      assert_equal has_strict_role, true
      assert_equal global_role, false
    end
    should "receive alert if role is not changed" do
      Organizations::Staff::UserRolesController.any_instance.stubs(:change_role).returns(false)
      post staff_user_to_admin_url(@account), headers: {"HTTP_REFERER" => "http://www.example.com/"}

      assert_response :redirect
      follow_redirect!

      assert_equal flash.alert, "Error changing role"
    end

    should "receive alert via turbo if role is not changed" do
      Organizations::Staff::UserRolesController.any_instance.stubs(:change_role).returns(false)
      post staff_user_to_admin_url(@account), as: :turbo_stream

      assert_equal flash.alert, "Error changing role"
    end
  end
end
