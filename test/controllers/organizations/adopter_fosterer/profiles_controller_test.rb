require "test_helper"
require "action_policy/test_helper"

class Organizations::AdopterFosterer::ProfilesControllerTest < ActionDispatch::IntegrationTest
  context "authorization" do
    include ActionPolicy::TestHelper

    setup do
      @user = create(:adopter)
      sign_in @user
    end

    context "#new" do
      should "be authorized" do
        assert_authorized_to(
          :create?, AdopterFosterProfile,
          with: Organizations::AdopterFosterProfilePolicy
        ) do
          get new_adopter_fosterer_profile_url
        end
      end
    end

    context "#create" do
      setup do
        @profile = build(:adopter_foster_profile,
          adopter_foster_account: @user.adopter_foster_account)
      end

      should "be authorized" do
        assert_authorized_to(
          :create?, AdopterFosterProfile,
          with: Organizations::AdopterFosterProfilePolicy
        ) do
          post adopter_fosterer_profile_url, params: attributes_for(:adopter_foster_profile)
        end
      end
    end

    context "#show" do
      setup do
        @profile = create(:adopter_foster_profile,
          adopter_foster_account: @user.adopter_foster_account)
      end

      should "be authorized" do
        assert_authorized_to(
          :manage?, @profile, with: Organizations::AdopterFosterProfilePolicy
        ) do
          get adopter_fosterer_profile_url
        end
      end
    end

    context "#edit" do
      setup do
        @profile = create(:adopter_foster_profile,
          adopter_foster_account: @user.adopter_foster_account)
      end

      should "be authorized" do
        assert_authorized_to(
          :manage?, @profile, with: Organizations::AdopterFosterProfilePolicy
        ) do
          get edit_adopter_fosterer_profile_url
        end
      end
    end

    context "#update" do
      setup do
        @profile = create(:adopter_foster_profile,
          adopter_foster_account: @user.adopter_foster_account)
        @params = {adopter_foster_profile: {
          experience: "heaps"
        }}
      end

      should "be authorized" do
        assert_authorized_to(
          :manage?, @profile, with: Organizations::AdopterFosterProfilePolicy
        ) do
          patch adopter_fosterer_profile_url, params: @params
        end
      end
    end
  end
end
