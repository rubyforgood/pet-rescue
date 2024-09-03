require "test_helper"

class Organizations::AdopterFosterer::MatchPolicyTest < ActiveSupport::TestCase
  include PetRescue::PolicyAssertions

  setup do
    @organization = ActsAsTenant.current_tenant
    @policy = -> {
      Organizations::AdopterFosterer::MatchPolicy.new(
        Match, user: @user, organization: @organization
      )
    }
  end

  context "relation_scope" do
    setup do
      @user = create(:user)
      @adopter_foster_account = create(:adopter_foster_account, user: @user, organization: @organization)
      @pet = create(:pet)
      @adopted_application = create(:adopter_application, adopter_foster_account: @adopter_foster_account, pet: @pet, status: :adoption_made)
      @match = create(:match, adopter_foster_account: @adopter_foster_account, pet: @pet, match_type: :adoption)

      @other_user = create(:user)
      @other_account = create(:adopter_foster_account, user: @other_user, organization: @organization)
      @other_pet = create(:pet)
      create(:adopter_application, adopter_foster_account: @other_account, pet: @other_pet, status: :adoption_made)
      @other_match = create(:match, adopter_foster_account: @other_account, pet: @other_pet, match_type: :adoption)

      ActsAsTenant.with_tenant(create(:organization)) do
        create(:match, adopter_foster_account: @adopter_foster_account, match_type: :adoption)
      end
    end

    should "return only the user's adopted pets" do
      scoped = @policy.call.apply_scope(Match.all, type: :active_record_relation)

      assert_equal 1, scoped.count
      assert_includes scoped, @match
    end
  end

  context "rules" do
    context "#index?" do
      setup do
        @action = -> { @policy.call.apply(:index?) }
      end

      context "when user is nil" do
        setup { @user = nil }
        should "return false" do
          assert_equal false, @action.call
        end
      end

      context "when user is adopter" do
        setup do
          @user = create(:adopter)
          @adopter_foster_account = create(:adopter_foster_account, user: @user, organization: @organization)
        end

        should "return true" do
          assert_equal true, @action.call
        end
      end

      context "when user is staff" do
        setup { @user = create(:admin) }
        should "return false" do
          assert_equal false, @action.call
        end
      end
    end
  end

  context "pre_check" do
    setup do
      @user = create(:user)
      @action = -> { @policy.call.apply(:index?) }
    end

    context "when user has an adopter_foster_account" do
      setup do
        create(:adopter_foster_account, user: @user, organization: @organization)
      end

      should "not raise an error" do
        assert_nothing_raised { @action.call }
      end
    end
  end
end
