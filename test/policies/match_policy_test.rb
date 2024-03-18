require "test_helper"

# See https://actionpolicy.evilmartians.io/#/testing?id=testing-policies
class MatchPolicyTest < ActiveSupport::TestCase
  include PetRescue::PolicyAssertions

  context "#create?" do
    setup do
      @organization = ActsAsTenant.current_tenant
      @policy = -> {
        MatchPolicy.new(Match, user: @user,
          organization: @organization)
      }
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
        @user = create(:adopter)
      end

      should "return false" do
        assert_equal @action.call, false
      end
    end

    context "when user is activated staff" do
      setup do
        @user = create(:staff)
      end

      context "when organization context is a different organization" do
        setup do
          @organization = create(:organization)
        end

        should "return false" do
          assert_equal @action.call, false
        end
      end

      context "when organization context is user's organization" do
        should "return true" do
          assert_equal @action.call, true
        end
      end
    end

    context "when user is deactivated staff" do
      setup do
        @user = create(:staff, :deactivated)
      end

      should "return false" do
        assert_equal @action.call, false
      end
    end

    context "when user is staff admin" do
      setup do
        @user = create(:staff_admin)
      end

      context "when organization context is a different organization" do
        setup do
          @organization = create(:organization)
        end

        should "return false" do
          assert_equal @action.call, false
        end
      end

      context "when organization context is user's organization" do
        should "return true" do
          assert_equal @action.call, true
        end
      end
    end
  end

  context "#destroy?" do
    setup do
      @match = create(:match)
      @policy = -> {
        MatchPolicy.new(@match, user: @user)
      }
      @action = -> { @policy.call.apply(:destroy?) }
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
        @user = create(:adopter)
      end

      should "return false" do
        assert_equal @action.call, false
      end
    end

    context "when user is activated staff" do
      setup do
        @user = create(:staff)
      end

      context "when match belongs to a different organization" do
        setup do
          ActsAsTenant.with_tenant(create(:organization)) do
            @match = create(:match)
          end
        end

        should "return false" do
          assert_equal @action.call, false
        end
      end

      context "when match belongs to user's organization" do
        should "return true" do
          assert_equal @action.call, true
        end
      end
    end

    context "when user is deactivated staff" do
      setup do
        @user = create(:staff, :deactivated)
      end

      should "return false" do
        assert_equal @action.call, false
      end
    end

    context "when user is staff admin" do
      setup do
        @user = create(:staff_admin)
      end

      context "when match belongs to a different organization" do
        setup do
          ActsAsTenant.with_tenant(create(:organization)) do
            @match = create(:match)
          end
        end

        should "return false" do
          assert_equal @action.call, false
        end
      end

      context "when match belongs to user's organization" do
        should "return true" do
          assert_equal @action.call, true
        end
      end
    end
  end
end
