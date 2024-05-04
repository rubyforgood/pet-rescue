require "test_helper"
require "action_policy/test_helper"

class Organizations::Staff::MatchesControllerTest < ActionDispatch::IntegrationTest
  context "authorization" do
    include ActionPolicy::TestHelper

    setup do
      user = create(:staff)
      sign_in user
    end

    context "create" do
      setup do
        @organization = ActsAsTenant.current_tenant

        pet = create(:pet)
        adopter_foster_account = create(:adopter_foster_account, :with_profile)
        @params = {
          match: {
            pet_id: pet.id,
            adopter_foster_account_id: adopter_foster_account.id,
            match_type: :adoption
          }
        }
      end

      should "be authorized" do
        assert_authorized_to(
          :create?, Match,
          context: {organization: @organization},
          with: Organizations::MatchPolicy
        ) do
          post staff_matches_url, params: @params
        end
      end
    end

    context "#destroy" do
      setup do
        @match = create(:match, match_type: :adoption)
      end

      should "be authorized" do
        assert_authorized_to(
          :destroy?, @match,
          with: Organizations::MatchPolicy
        ) do
          delete staff_match_url(@match)
        end
      end
    end
  end
end
