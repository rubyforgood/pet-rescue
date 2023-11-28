# frozen_string_literal: true
require "test_helper"

class OrganizationProfile::EditProfileTest < ActionDispatch::IntegrationTest
  setup do
    @org = ActsAsTenant.test_tenant
    @org_profile = @org.profile
    admin = create(:user, :staff_admin, organization: @org)
    set_organization(admin.organization)
    sign_in admin
    get edit_organization_profile_path(@org_profile)
  end

  test "all expected fields are present on the edit organization profile page" do 
    assert_select "h4", text: "Your avatar"
    assert_select "p", text: "PNG or JPG, size must be between 10kb and 1Mb"

    assert_select "label", text: "Phone number"
    assert_select "input[name='organization_profile[phone_number]'][type='tel']"

    assert_select "label", text: "Email"
    assert_select "input[name='organization_profile[email]'][type='text']"

    assert_select "label", text: "Country"
    assert_select "select[name='organization_profile[location_attributes][province_state]']"

    assert_select "label", text: "City/Town"
    assert_select "input[name='organization_profile[location_attributes][city_town]'][type='text']"

    assert_select 'input[type="submit"][value="Save profile"]'
  end

  test 'organization profile updates with the submission of the form' do
    patch organization_profile_path(@org_profile), params: {
      organization_profile: {
        email: "happy_paws_rescue@gmail.com",
        phone_number: "3038947563",
        about_us: "Finding pets loving homes across the front range!",
        location_attributes: {
          country: "United States",
          province_state: "Colorado",
          city_town: "Golden"
        }
      }
    }
    @org_profile.reload

    assert_response :redirect
    follow_redirect!
    assert_response :success

    assert_equal "happy_paws_rescue@gmail.com", @org_profile.email
    assert_equal "+13038947563", @org_profile.phone_number
    assert_equal "Finding pets loving homes across the front range!", @org_profile.about_us
    assert_equal "United States", @org_profile.location.country
    assert_equal "Colorado", @org_profile.location.province_state
    assert_equal "Golden", @org_profile.location.city_town
  end
end