require "test_helper"

# See https://actionpolicy.evilmartians.io/#/testing?id=testing-policies
class Organizations::OrganizationProfilePolicyTest < ActiveSupport::TestCase
  include PetRescue::PolicyAssertions

  setup do
    @organization = ActsAsTenant.current_tenant
    @policy = -> {
      Organizations::OrganizationProfilePolicy.new(Pet, user: @user,
        organization: @organization)
    }
  end

  context "#manage?" do
    setup do
      @action = -> { @policy.call.apply(:manage?) }
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

    context "when user is active staff" do
      setup do
        @user = create(:user, :activated_staff)
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

    context "when user is staff admin" do
      setup do
        @user = create(:user, :staff_admin)
      end

      should "return true" do
        assert_equal @action.call, true
      end
    end
  end

  context "#edit?" do
    should "be an alias to :manage?" do
      assert_alias_rule @policy.call, :edit?, :manage?
    end
  end

  context "#update?" do
    should "be an alias to :manage?" do
      assert_alias_rule @policy.call, :update?, :manage?
    end
  end
end
