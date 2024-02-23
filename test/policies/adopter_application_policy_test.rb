require "test_helper"

# See https://actionpolicy.evilmartians.io/#/testing?id=testing-policies
class AdopterApplicationPolicyTest < ActiveSupport::TestCase
  include PetRescue::PolicyAssertions

  context "#index?" do
    setup do
      @policy = -> {
        AdopterApplicationPolicy.new(AdopterApplication, user: @user)
      }
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

    context "when user is adopter without adopter account" do
      setup do
        @user = create(:user)
      end

      should "return false" do
        assert_equal @action.call, false
      end
    end

    context "when user is adopter without profile" do
      setup do
        @user = create(:user, :adopter_without_profile)
      end

      should "return false" do
        assert_equal @action.call, false
      end
    end

    context "when user is adopter with profile" do
      setup do
        @user = create(:user, :adopter_with_profile)
      end

      should "return true" do
        assert_equal @action.call, true
      end
    end
  end

  context "#create?" do
    setup do
      @pet = create(:pet)
      @policy = -> {
        AdopterApplicationPolicy.new(AdopterApplication, user: @user,
          pet: @pet)
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

    context "when user is adopter without adopter account" do
      setup do
        @user = create(:user)
      end

      should "return false" do
        assert_equal @action.call, false
      end
    end

    context "when user is adopter without profile" do
      setup do
        @user = create(:user, :adopter_without_profile)
      end

      should "return false" do
        assert_equal @action.call, false
      end
    end

    context "when user is adopter with profile" do
      setup do
        @user = create(:user, :adopter_with_profile)
      end

      context "when pet application is paused" do
        setup do
          @pet = create(:pet, application_paused: true)
        end

        should "return false" do
          assert_equal @action.call, false
        end
      end

      context "when pet application is not paused" do
        setup do
          @pet = create(:pet, application_paused: false)
        end

        should "return true" do
          assert_equal @action.call, true
        end
      end
    end
  end

  context "existing record action" do
    setup do
      @adopter_application = create(:adopter_application)
      @policy = -> {
        AdopterApplicationPolicy.new(@adopter_application, user: @user)
      }
    end

    context "#update?" do
      setup do
        @action = -> { @policy.call.apply(:update?) }
      end

      context "when user is nil" do
        setup do
          @user = nil
        end

        should "return false" do
          assert_equal @action.call, false
        end
      end

      context "when adopter account does not belong to user" do
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

          should "return false" do
            assert_equal @action.call, false
          end
        end

        context "when user is staff admin" do
          setup do
            @user = create(:user, :staff_admin)
          end

          should "return false" do
            assert_equal @action.call, false
          end
        end
      end

      context "when adopter account belongs to user" do
        setup do
          @user = @adopter_application.adopter_account.user
        end

        should "return true" do
          assert_equal @action.call, true
        end
      end
    end
  end
end
