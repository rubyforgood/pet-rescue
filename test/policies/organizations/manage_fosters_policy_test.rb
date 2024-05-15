require "test_helper"

# See https://actionpolicy.evilmartians.io/#/testing?id=testing-policies
class Organizations::ManageFostersPolicyTest < ActiveSupport::TestCase
  include PetRescue::PolicyAssertions

  setup do
    @staff = create(:staff_account)
    @policy = -> { Organizations::ManageFostersPolicy.new(@staff, user: @user) }
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

    context "when user is staff" do
      setup do
        @user = create(:staff)
      end

      should "return false" do
        assert_equal @action.call, true
      end
    end

    context "when user is staff admin" do
      setup do
        @user = create(:staff_admin)
      end

      context "when user's staff account is deactivated" do
        setup do
          @user.staff_account.deactivate
        end

        should "return false" do
          assert_equal @action.call, false
        end
      end

      should "return true" do
        assert_equal @action.call, true
      end
    end
  end
end
