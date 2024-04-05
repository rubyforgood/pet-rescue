require "test_helper"
require "action_policy/test_helper"

class Organizations::MatchesControllerTest < ActionDispatch::IntegrationTest
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
            adopter_foster_account_id: adopter_foster_account.id
          }
        }
      end

      should "be authorized" do
        assert_authorized_to(
          :create?, Match,
          context: {organization: @organization},
          with: Organizations::MatchPolicy
        ) do
          post matches_url, params: @params
        end
      end
    end

    context "#destroy" do
      setup do
        @match = create(:match)
      end

      should "be authorized" do
        assert_authorized_to(
          :destroy?, @match,
          with: Organizations::MatchPolicy
        ) do
          delete match_url(@match)
        end
      end
    end
  end
end
