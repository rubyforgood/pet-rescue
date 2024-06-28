require "test_helper"

# See https://actionpolicy.evilmartians.io/#/testing?id=testing-policies
class Organizations::CustomPagePolicyTest < ActiveSupport::TestCase
  include PetRescue::PolicyAssertions

  setup do
    @organization = ActsAsTenant.current_tenant
    @policy = -> {
      Organizations::CustomPagePolicy.new(Pet, user: @user,
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
        assert_equal false, @action.call
      end
    end

    context "when user is adopter" do
      setup do
        @user = create(:adopter)
      end

      should "return false" do
        assert_equal false, @action.call
      end
    end

    context "when user is fosterer" do
      setup do
        @user = create(:fosterer)
      end

      should "return false" do
        assert_equal false, @action.call
      end
    end

    context "when user is deactivated staff" do
      setup do
        @user = create(:staff, :deactivated)
      end

      should "return false" do
        assert_equal false, @action.call
      end
    end

    context "when user is active staff" do
      setup do
        @user = create(:staff)
      end

      should "return false" do
        assert_equal false, @action.call
      end
    end

    context "when user is staff admin" do
      setup do
        @user = create(:staff_admin)
      end

      should "return true" do
        assert_equal true, @action.call
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
