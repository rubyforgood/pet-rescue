require "test_helper"

# See https://actionpolicy.evilmartians.io/#/testing?id=testing-policies
class Organizations::PetPolicyTest < ActiveSupport::TestCase
  context "context action" do
    setup do
      @organization = ActsAsTenant.current_tenant
      @policy = -> {
        Organizations::PetPolicy.new(Pet, user: @user,
          organization: @organization)
      }
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

      context "when user is admin" do
        setup do
          @user = create(:user, :staff_admin)
        end

        should "return true" do
          assert_equal @action.call, true
        end
      end
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

      context "when user is admin" do
        setup do
          @user = create(:user, :staff_admin)
        end

        should "return true" do
          assert_equal @action.call, true
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

  context "existing record action" do
    setup do
      @pet = create(:pet)
      @policy = -> { Organizations::PetPolicy.new(@pet, user: @user) }
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

      context "when user is admin" do
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

      context "when user is admin" do
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
    end

    context "#edit?" do
      setup do
        @action = -> { @policy.call.apply(:edit?) }
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

      context "when user is admin" do
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

      context "when user is admin" do
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
    end

    context "#destroy?" do
      setup do
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

      context "when user is admin" do
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
    end

    context "#attach_images?" do
      setup do
        @action = -> { @policy.call.apply(:attach_images?) }
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

      context "when user is admin" do
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
    end

    context "#attach_files?" do
      setup do
        @action = -> { @policy.call.apply(:attach_files?) }
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

      context "when user is admin" do
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
    end
  end
end
