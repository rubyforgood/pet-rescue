require "test_helper"

# See https://actionpolicy.evilmartians.io/#/testing?id=testing-policies
class Organizations::DashboardPolicyTest < ActiveSupport::TestCase
  include PetRescue::PolicyAssertions

  setup do
    @organization = ActsAsTenant.current_tenant
    @policy = -> {
      Organizations::DashboardPolicy.new(
        organization: @organization,
        user: @user
      )
    }
  end

  context "#index?" do
    setup do
      @action = -> { @policy.call.apply(:index?) }
    end

    context "when user is nil" do
      setup do
        @user = nil
      end

      should "return false" do
        assert_equal @action.call, false
      end
    end

    context "when user is adopter" do
      setup do
        @user = create(:user, :adopter_without_profile)
      end

      should "return false" do
        assert_equal @action.call, false
      end
    end

    context "when user is deactivated staff" do
      setup do
        @user = create(:user, :deactivated_staff)
      end

      should "return false" do
        assert_equal @action.call, false
      end
    end

    context "when user is activated staff" do
      setup do
        @user = create(:user, :activated_staff)
      end

      should "return true" do
        assert_equal @action.call, true
      end
    end

    context "when user is staff admin" do
      setup do
        @user = create(:user, :staff_admin)
      end

      should "return true" do
        assert_equal @action.call, true
      end
    end
  end
end
