require "test_helper"
require "action_policy/test_helper"

class Organizations::Staff::DashboardControllerTest < ActionDispatch::IntegrationTest
  context "authorization" do
    include ActionPolicy::TestHelper

    setup do
      @organization = ActsAsTenant.current_tenant

      user = create(:staff)
      sign_in user
    end

    context "#index" do
      should "be authorized" do
        assert_authorized_to(
          :index?, :dashboard,
          context: {organization: @organization},
          with: Organizations::DashboardPolicy
        ) do
          get staff_dashboard_index_url
        end
      end
    end
  end
end
