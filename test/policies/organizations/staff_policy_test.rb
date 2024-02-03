require "test_helper"

# See https://actionpolicy.evilmartians.io/#/testing?id=testing-policies
class Organizations::StaffPolicyTest < ActiveSupport::TestCase
  def setup
    @policy = -> { Organizations::StaffPolicy.new(@staff, user: @user) }
  end

  context "#deactivate?" do
  end

  context "#activate?" do
  end

  context "#update_activation?" do
  end

  context "#index?" do
    setup do
      @staff = create(:staff_account)

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

      should "return true" do
        assert_equal @action.call, true
      end
    end
  end
end
