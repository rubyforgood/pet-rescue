require "test_helper"

# See https://actionpolicy.evilmartians.io/#/testing?id=testing-policies
class Organizations::InvitationPolicyTest < ActiveSupport::TestCase
  setup do
    @organization = ActsAsTenant.current_tenant
    @policy = -> {
      Organizations::InvitationPolicy.new(
        StaffAccount, organization: @organization, user: @user
      )
    }
  end

  context "#new?" do
    setup do
      @action = -> { @policy.call.apply(:new?) }
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

    context "when user is staff" do
      setup do
        @user = create(:user, :activated_staff)
      end

      should "return false" do
        assert_equal @action.call, false
      end
    end

    context "when user is admin" do
      setup do
        @user = create(:user, :staff_admin)
      end

      context "when new staff is for a different organization" do
        setup do
          @organization = create(:organization)
        end

        should "return false" do
          assert_equal @action.call, false
        end
      end

      context "when created staff is for the same organization" do
        should "return true" do
          assert_equal @action.call, true
        end
      end
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

    context "when user is staff" do
      setup do
        @user = create(:user, :activated_staff)
      end

      should "return false" do
        assert_equal @action.call, false
      end
    end

    context "when user is admin" do
      setup do
        @user = create(:user, :staff_admin)
      end

      context "when created staff is for a different organization" do
        setup do
          @organization = create(:organization)
        end

        should "return false" do
          assert_equal @action.call, false
        end
      end

      context "when created staff is for the same organization" do
        should "return true" do
          assert_equal @action.call, true
        end
      end
    end
  end
end
