require "test_helper"
require "action_policy/test_helper"

class Organizations::OrganizationProfilesControllerTest < ActionDispatch::IntegrationTest
  context "authorization" do
    include ActionPolicy::TestHelper

    setup do
      @organization = ActsAsTenant.current_tenant
      @organization_profile = @organization.profile

      user = create(:staff)
      sign_in user
    end

    context "#edit" do
      should "be authorized" do
        assert_authorized_to(
          :manage?, @organization_profile, with: Organizations::OrganizationProfilePolicy
        ) do
          get edit_organization_profile_url(@organization_profile)
        end
      end
    end

    context "#update" do
      setup do
        @params = {facebook_url: "https://facebook.com"}
      end

      should "be authorized" do
        assert_authorized_to(
          :manage?, @organization_profile, with: Organizations::OrganizationProfilePolicy
        ) do
          patch organization_profile_url(@organization_profile), params: @params
        end
      end
    end
  end
end
