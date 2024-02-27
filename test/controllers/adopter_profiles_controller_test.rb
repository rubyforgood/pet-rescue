require "test_helper"
require "action_policy/test_helper"

class AdopterProfilesControllerTest < ActionDispatch::IntegrationTest
  context "authorization" do
    include ActionPolicy::TestHelper

    setup do
      @user = create(:adopter)
      sign_in @user
    end

    context "#new" do
      should "be authorized" do
        assert_authorized_to(
          :create?, AdopterProfile,
          with: AdopterProfilePolicy
        ) do
          get new_profile_url
        end
      end
    end

    context "#create" do
      setup do
        @profile = build(:adopter_profile,
          adopter_account: @user.adopter_account)
      end

      should "be authorized" do
        assert_authorized_to(
          :create?, AdopterProfile,
          with: AdopterProfilePolicy
        ) do
          post profile_url, params: attributes_for(:adopter_profile)
        end
      end
    end

    context "#show" do
      setup do
        @profile = create(:adopter_profile,
          adopter_account: @user.adopter_account)
      end

      should "be authorized" do
        assert_authorized_to(
          :manage?, @profile, with: AdopterProfilePolicy
        ) do
          get profile_url
        end
      end
    end

    context "#edit" do
      setup do
        @profile = create(:adopter_profile,
          adopter_account: @user.adopter_account)
      end

      should "be authorized" do
        assert_authorized_to(
          :manage?, @profile, with: AdopterProfilePolicy
        ) do
          get edit_profile_url
        end
      end
    end

    context "#update" do
      setup do
        @profile = create(:adopter_profile,
          adopter_account: @user.adopter_account)
        @params = {adopter_profile: {
          experience: "heaps"
        }}
      end

      should "be authorized" do
        assert_authorized_to(
          :manage?, @profile, with: AdopterProfilePolicy
        ) do
          patch profile_url, params: @params
        end
      end
    end
  end
end
