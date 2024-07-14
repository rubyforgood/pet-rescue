require "test_helper"

# See https://actionpolicy.evilmartians.io/#/testing?id=testing-policies
class Organizations::AdopterFosterAccountPolicyTest < ActiveSupport::TestCase
  include PetRescue::PolicyAssertions

  setup do
    @policy = -> {
      Organizations::AdopterFosterAccountPolicy.new(
        AdopterFosterAccount, user: @user,
        organization: ActsAsTenant.current_tenant
      )
    }
  end

  context "relation_scope" do
    setup do
      @user = build_stubbed(:staff)
      @account1 = create(:adopter_foster_account)
      @account2 = create(:adopter_foster_account)

      ActsAsTenant.with_tenant(create(:organization)) do
        create(:adopter_foster_account)
      end
    end

    should "return organization's adopter foster accounts" do
      expected = [@account1, @account2].map(&:id)

      scoped = @policy.call
        .apply_scope(AdopterFosterAccount.all, type: :active_record_relation)
        .pluck(:id)

      assert_equal expected, scoped
    end
  end

  context "context only rules" do
    context "#index?" do
      setup do
        @action = -> { @policy.call.apply(:index?) }
      end

      context "when user is nil" do
        setup do
          @user = nil
        end

        should "return false" do
          assert_equal false, @action.call
        end
      end

      context "when user is adopter" do
        setup do
          @user = create(:adopter)
        end

        should "return false" do
          assert_equal false, @action.call
        end
      end

      context "when user is fosterer" do
        setup do
          @user = create(:fosterer)
        end

        should "return false" do
          assert_equal false, @action.call
        end
      end

      context "when user is staff" do
        setup do
          @user = create(:staff)
        end

        context "when user's staff account is deactivated" do
          setup do
            @user.staff_account.deactivate
          end

          should "return false" do
            assert_equal false, @action.call
          end
        end

        should "return true" do
          assert_equal true, @action.call
        end
      end

      context "when user is staff admin" do
        setup do
          @user = create(:super_admin)
        end

        context "when user's staff account is deactivated" do
          setup do
            @user.staff_account.deactivate
          end

          should "return false" do
            assert_equal false, @action.call
          end
        end

        should "return true" do
          assert_equal true, @action.call
        end
      end
    end
  end
end
