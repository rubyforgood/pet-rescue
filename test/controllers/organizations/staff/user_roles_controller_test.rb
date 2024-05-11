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
  end
end
