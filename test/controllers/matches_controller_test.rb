require "test_helper"
require "action_policy/test_helper"

class MatchesControllerTest < ActionDispatch::IntegrationTest
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
        adopter_account = create(:adopter_account, :with_profile)
        @params = {
          match: {
            pet_id: pet.id,
            adopter_account_id: adopter_account.id
          }
        }
      end

      should "be authorized" do
        assert_authorized_to(
          :create?, Match,
          context: {organization: @organization},
          with: MatchPolicy
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
          with: MatchPolicy
        ) do
          delete match_url(@match)
        end
      end
    end
  end
end
