require "test_helper"
require "action_policy/test_helper"

class Organizations::AdopterFosterer::AdoptedPetsControllerTest < ActionDispatch::IntegrationTest
  context "authorization" do
    include ActionPolicy::TestHelper

    setup do
      @organization = ActsAsTenant.current_tenant
      @adopter_foster_account = create(:adopter_foster_account, organization: @organization)
      sign_in @adopter_foster_account.user
    end

    context "#index" do
      should "be authorized" do
        assert_authorized_to(
          :index?, Match, with: Organizations::AdopterFosterer::MatchPolicy
        ) do
          get adopter_fosterer_adopted_pets_url
        end
      end

      should "have authorized scope" do
        ActsAsTenant.with_tenant(@organization) do
          assert_have_authorized_scope(
            type: :active_record_relation,
            with: Organizations::AdopterFosterer::MatchPolicy
          ) do
            get adopter_fosterer_adopted_pets_url
          end
        end
      end

      should "return only adoption matches for the user's adopter_fosterer_account" do
        ActsAsTenant.with_tenant(@organization) do
          user_adoption_match = create(:match, :adoption, adopter_foster_account: @adopter_foster_account, organization: @organization)
          other_account_adoption_match = create(:match, :adoption, organization: @organization)
          other_org_adoption_match = create(:match, :adoption)

          get adopter_fosterer_adopted_pets_url

          assert_includes assigns(:adopted_pets), user_adoption_match
          assert_not_includes assigns(:adopted_pets), other_account_adoption_match
          assert_not_includes assigns(:adopted_pets), other_org_adoption_match
        end
      end
    end
  end
end
