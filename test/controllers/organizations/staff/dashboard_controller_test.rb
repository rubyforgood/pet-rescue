require "test_helper"
require "action_policy/test_helper"

class Organizations::Staff::DashboardControllerTest < ActionDispatch::IntegrationTest
  context "authorization" do
    include ActionPolicy::TestHelper

    setup do
      @organization = ActsAsTenant.current_tenant

      user = create(:admin)
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

    context "#incomplete_tasks" do
      should "be authorized" do
        assert_authorized_to(
          :incomplete_tasks?, :dashboard,
          context: {organization: @organization},
          with: Organizations::DashboardPolicy
        ) do
          get incomplete_tasks_staff_dashboard_index_url, headers: {"Turbo-Frame" => "tasks-frame"}
        end
      end

      should "return turbo_stream response" do
        get incomplete_tasks_staff_dashboard_index_url, headers: {"Turbo-Frame" => "tasks-frame"}
        assert_response :success
        assert_match "tasks-frame", response.body
      end
    end

    context "#overdue_tasks" do
      should "be authorized" do
        assert_authorized_to(
          :overdue_tasks?, :dashboard,
          context: {organization: @organization},
          with: Organizations::DashboardPolicy
        ) do
          get overdue_tasks_staff_dashboard_index_url, headers: {"Turbo-Frame" => "tasks-frame"}
        end
      end

      should "return turbo_stream response" do
        get overdue_tasks_staff_dashboard_index_url, headers: {"Turbo-Frame" => "tasks-frame"}
        assert_response :success
        assert_match "tasks-frame", response.body
      end
    end
  end
end
