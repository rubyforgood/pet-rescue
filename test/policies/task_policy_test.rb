require "test_helper"

# See https://actionpolicy.evilmartians.io/#/testing?id=testing-policies
class TaskPolicyTest < ActiveSupport::TestCase
  include PetRescue::PolicyAssertions

  context "context only action" do
    setup do
      @organization = ActsAsTenant.current_tenant
      @pet = create(:pet)
      @policy = -> {
        TaskPolicy.new(Task, user: @user,
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

        should "return true" do
          assert_equal @action.call, true
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
        TaskPolicy.new(@task, user: @user,
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

        should "return true" do
          assert_equal @action.call, true
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

        context "when pet is from a different organization" do
          setup do
            @other_organization = create(:organization)
            ActsAsTenant.with_tenant(@other_organization) do
              @pet = create(:pet, organization: @other_organization)
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
          @user = create(:user, :activated_staff)
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
