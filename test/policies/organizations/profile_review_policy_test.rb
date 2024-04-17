require "test_helper"

# See https://actionpolicy.evilmartians.io/#/testing?id=testing-policies
class Organizations::ProfileReviewPolicyTest < ActiveSupport::TestCase
  include PetRescue::PolicyAssertions

  setup do
    @adopter_foster_profile = create(:adopter_foster_profile)
    @policy = -> {
      Organizations::ProfileReviewPolicy.new(
        @adopter_foster_profile, user: @user
      )
    }
  end

  context "#show?" do
    setup do
      @action = -> { @policy.call.apply(:show?) }
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

    context "when user is fosterer" do
      setup do
        @user = create(:fosterer)
      end

      should "return false" do
        assert_equal @action.call, false
      end
    end

    context "when user is activated staff" do
      setup do
        @user = create(:staff)
      end

      context "when application belongs to a different organization" do
        setup do
          ActsAsTenant.with_tenant(create(:organization)) do
            @adopter_foster_profile = create(:adopter_foster_profile)
          end
        end

        should "return false" do
          assert_equal @action.call, false
        end
      end

      context "when application belongs to user's organization" do
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

      context "when application belongs to a different organization" do
        setup do
          ActsAsTenant.with_tenant(create(:organization)) do
            @adopter_foster_profile = create(:adopter_foster_profile)
          end
        end

        should "return false" do
          assert_equal @action.call, false
        end
      end

      context "when application belongs to user's organization" do
        should "return true" do
          assert_equal @action.call, true
        end
      end
    end
  end
end
