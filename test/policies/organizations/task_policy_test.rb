require "test_helper"

# See https://actionpolicy.evilmartians.io/#/testing?id=testing-policies
class Organizations::TaskPolicyTest < ActiveSupport::TestCase
  include PetRescue::PolicyAssertions

  context "context only action" do
    setup do
      @organization = ActsAsTenant.current_tenant
      @pet = create(:pet)
      @policy = -> {
        Organizations::TaskPolicy.new(Task, user: @user,
          organization: @organization,
          pet: @pet)
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
          @user = create(:adopter)
        end

        should "return false" do
          assert_equal @action.call, false
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

      context "when user is active staff" do
        setup do
          @user = create(:staff)
        end

        should "return true" do
          assert_equal @action.call, true
        end
      end

      context "when user is staff admin" do
        setup do
          @user = create(:staff_admin)
        end

        should "return true" do
          assert_equal @action.call, true
        end
      end
    end

    context "#new?" do
      should "be an alias to :manage?" do
        assert_alias_rule @policy.call, :new?, :manage?
      end
    end

    context "#create?" do
      should "be an alias to :manage?" do
        assert_alias_rule @policy.call, :create?, :manage?
      end
    end
  end

  context "existing record action" do
    setup do
      @pet = create(:pet)
      @task = create(:task, pet: @pet)
      @policy = -> {
        Organizations::TaskPolicy.new(@task, user: @user,
          organization: @pet.organization)
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
          @user = create(:adopter)
        end

        should "return false" do
          assert_equal @action.call, false
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

      context "when user is active staff" do
        setup do
          @user = create(:staff)
        end

        should "return true" do
          assert_equal @action.call, true
        end
      end

      context "when user is staff admin" do
        setup do
          @user = create(:staff_admin)
        end

        context "when pet is from a different organization" do
          setup do
            @other_organization = create(:organization)
            ActsAsTenant.with_tenant(@other_organization) do
              @pet = create(:pet)
            end
          end

          should "return false" do
            assert_equal @action.call, false
          end
        end

        context "when pet is from the same organization" do
          should "return true" do
            assert_equal @action.call, true
          end
        end
      end

      context "when user is not allowed to manage pets" do
        setup do
          @user = create(:staff)
          @user.expects(:permission?).with(:manage_pets).returns(false)
        end

        should "return false" do
          assert_equal @action.call, false
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

    context "#destroy?" do
      should "be an alias to :manage?" do
        assert_alias_rule @policy.call, :destroy?, :manage?
      end
    end
  end
end
