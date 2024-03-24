require "test_helper"
require "action_policy/test_helper"

class ProfileReviewsControllerTest < ActionDispatch::IntegrationTest
  context "authorization" do
    include ActionPolicy::TestHelper

    setup do
      user = create(:staff)
      sign_in user
    end

    context "#show" do
      setup do
        @profile = create(:adopter_foster_profile)
      end

      should "be authorized" do
        assert_authorized_to(
          :show?, @profile,
          with: ProfileReviewPolicy
        ) do
          get profile_review_url(@profile)
        end
      end
    end
  end
end
