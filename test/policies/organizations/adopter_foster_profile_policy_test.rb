require "test_helper"

# See https://actionpolicy.evilmartians.io/#/testing?id=testing-policies
class Organizations::AdopterFosterProfilePolicyTest < ActiveSupport::TestCase
  include PetRescue::PolicyAssertions

  context "#new?" do
    setup do
      @policy = -> { Organizations::AdopterFosterProfilePolicy.new(AdopterFosterProfile, user: @user) }
    end

    should "be an alias to :create?" do
      assert_alias_rule @policy.call, :new?, :create?
    end
  end

  context "#create?" do
    setup do
      @policy = -> { Organizations::AdopterFosterProfilePolicy.new(AdopterFosterProfile, user: @user) }
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

    context "when user is adopter without profile" do
      setup do
        @user = create(:adopter)
      end

      should "return true" do
        assert_equal @action.call, true
      end
    end

    context "when user is adopter with profile" do
      setup do
        @user = create(:adopter, :with_profile)
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
        assert_equal @action.call, false
      end
    end

    context "when user is staff admin" do
      setup do
        @user = create(:staff_admin)
      end

      should "return false" do
        assert_equal @action.call, false
      end
    end
  end

  context "existing record action" do
    setup do
      @profile = create(:adopter_foster_profile)
      @policy = -> { Organizations::AdopterFosterProfilePolicy.new(@profile, user: @user) }
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

      context "when user is adopter without profile" do
        setup do
          @user = create(:adopter)
        end

        should "return false" do
          assert_equal @action.call, false
        end
      end

      context "when user is adopter with profile" do
        setup do
          @user = create(:adopter, :with_profile)
        end

        context "when profile does not belong to user" do
          should "return false" do
            assert_equal @action.call, false
          end
        end

        context "when profile belongs to user" do
          setup do
            @user = @profile.adopter_foster_account.user
          end

          should "return true" do
            assert_equal @action.call, true
          end
        end
      end

      context "when user is staff" do
        setup do
          @user = create(:staff)
        end

        should "return false" do
          assert_equal @action.call, false
        end
      end

      context "when user is staff admin" do
        setup do
          @user = create(:staff_admin)
        end

        should "return false" do
          assert_equal @action.call, false
        end
      end
    end

    context "#show?" do
      should "be an alias to :manage?" do
        assert_alias_rule @policy.call, :show?, :manage?
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
end
