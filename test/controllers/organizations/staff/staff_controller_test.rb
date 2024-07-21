require "test_helper"
require "action_policy/test_helper"

class Organizations::Staff::StaffControllerTest < ActionDispatch::IntegrationTest
  setup do
    @organization = ActsAsTenant.current_tenant
    @staff = create(:staff_account)
    sign_in @staff.user
  end

  context "authorization" do
    include ActionPolicy::TestHelper

    context "#deactivate" do
      should "be authorized" do
        assert_authorized_to(
          :activate?, @staff, with: Organizations::StaffAccountPolicy
        ) do
          post staff_staff_deactivate_url(@staff)
        end
      end
    end

    context "#activate" do
      should "be authorized" do
        assert_authorized_to(
          :activate?, @staff, with: Organizations::StaffAccountPolicy
        ) do
          post staff_staff_activate_url(@staff)
        end
      end
    end

    context "#update_activation" do
      should "be authorized" do
        assert_authorized_to(
          :activate?, @staff, with: Organizations::StaffAccountPolicy
        ) do
          post staff_staff_update_activation_url(@staff)
        end
      end
    end

    context "#index" do
      should "be authorized" do
        assert_authorized_to(
          :index?, StaffAccount,
          context: {organization: @organization},
          with: Organizations::StaffAccountPolicy
        ) do
          get staff_staff_index_url
        end
      end

      context "when user is authorized" do
        setup do
          user = create(:super_admin)
          sign_in user
        end

        should "have authorized scope" do
          assert_have_authorized_scope(
            type: :active_record_relation, with: Organizations::StaffAccountPolicy
          ) do
            get staff_staff_index_url
          end
        end
      end
    end
  end

  test "update activation should respond with turbo_stream when toggled on staff page" do
    user = create(:super_admin)
    sign_in user

    post staff_staff_update_activation_url(@staff), as: :turbo_stream

    assert_equal Mime[:turbo_stream], response.media_type
    assert_response :success
  end
end
