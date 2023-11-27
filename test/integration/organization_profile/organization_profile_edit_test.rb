# frozen_string_literal: true
require "test_helper"

class OrganizationProfile::EditProfileTest < ActionDispatch::IntegrationTest
  setup do
    @org = create(:organization)
    @org_profile = create(:organization_profile, organization_id: @org.id)

    admin = create(:user, :staff_admin)
    set_organization(admin.organization)
    sign_in admin
    get edit_organization_profile_path(@org)
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

    # assert_select "button[type='submit']", text: "Save profile"
  end

  test 'organization profile updates with the submission of the form' do
    patch organization_profile_path(@org_profile), params: {
      organization_profile: {
        phone_number: "+13038947563",
        email: "happy_paws_rescue@gmail.com",
        location_attributes: [
          country: "United States",
          province_state: "Colorado",
          city_town: "Golden"
        ] 
      }
    }

    @org_profile.reload

    assert_response :redirect
    follow_redirect!
    assert_response :success

    assert_equal "+13038947563", @org_profile.phone_number
    assert_equal "happy_paws_rescue@gmail.com", @org_profile.email
    assert_equal "United States", @org_profile.location.country
  end
end