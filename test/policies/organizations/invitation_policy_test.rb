require "test_helper"

# See https://actionpolicy.evilmartians.io/#/testing?id=testing-policies
class Organizations::InvitationPolicyTest < ActiveSupport::TestCase
  include PetRescue::PolicyAssertions

  setup do
    @organization = ActsAsTenant.current_tenant
    @policy = -> {
      Organizations::InvitationPolicy.new(
        User, organization: @organization, user: @user
      )
    }
  end

  context "#new?" do
    should "be an alias to :create?" do
      assert_alias_rule @policy.call, :new?, :create?
    end
  end

  context "#create?" do
    setup do
      @action = -> { @policy.call.apply(:create?) }
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

      should "return false" do
        assert_equal false, @action.call
      end
    end
  end
end
