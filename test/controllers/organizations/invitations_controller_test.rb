require "test_helper"
require "action_policy/test_helper"

class Organizations::InvitationControllerTest < ActionDispatch::IntegrationTest
  context "authorization" do
    include ActionPolicy::TestHelper

    setup do
      @organization = ActsAsTenant.current_tenant
      user = create(:user, :staff_admin)
      sign_in user
    end

    context "#new" do
      should "be authorized" do
        assert_authorized_to(
          :create?, StaffAccount,
          context: {organization: @organization},
          with: Organizations::InvitationPolicy
        ) do
          get new_user_invitation_url
        end
      end
    end

    context "#create" do
      setup do
        @params = {
          user: {
            first_name: "John",
            last_name: "Doe",
            email: "john@example.com",
            roles: "admin"
          }
        }
      end

      should "be authorized" do
        assert_authorized_to(
          :create?, StaffAccount,
          context: {organization: @organization},
          with: Organizations::InvitationPolicy
        ) do
          post user_invitation_url, params: @params
        end
      end
    end
  end
end
