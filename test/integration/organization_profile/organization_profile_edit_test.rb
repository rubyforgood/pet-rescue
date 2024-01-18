# frozen_string_literal: true

require "test_helper"

class OrganizationProfile::EditProfileTest < ActionDispatch::IntegrationTest
  setup do
    @org = ActsAsTenant.test_tenant
    @org_profile = @org.profile
    admin = create(:user, :staff_admin, organization: @org)
    sign_in admin
    get edit_organization_profile_path(@org_profile)
  end

  test "all expected fields are present on the edit organization profile page" do
    assert_select "label", text: "Phone number"
    assert_select "input[name='organization_profile[phone_number]'][type='tel']"

    assert_select "label", text: "Email"
    assert_select "input[name='organization_profile[email]'][type='text']"

    assert_select "label", text: "Country"
    assert_select "select[name='organization_profile[location_attributes][province_state]']"

    assert_select "label", text: "City/Town"
    assert_select "input[name='organization_profile[location_attributes][city_town]'][type='text']"

    assert_select "label", text: "Attach picture"
    assert_select "input[name='organization_profile[avatar]']"

    assert_select 'input[type="submit"][value="Save profile"]'
  end

  test "organization profile updates with the submission of the form" do
    patch organization_profile_path(@org_profile), params: {
      organization_profile: {
        email: "happy_paws_rescue@gmail.com",
        phone_number: "3038947563",
        about_us: "Finding pets loving homes across the front range!",
        location_attributes: {
          country: "United States",
          province_state: "Colorado",
          city_town: "Golden"
        },
        avatar: fixture_file_upload("/logo.png")
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
    assert_equal "logo.png", @org_profile.avatar.filename.sanitized
  end

  test "organization profile updates with only some form fields to update" do
    patch organization_profile_path(@org_profile), params: {
      organization_profile: {
        phone_number: "3038947542",
        about_us: "Finding pets loving homes across the Denver Metro area"
      }
    }
    @org_profile.reload

    assert_response :redirect
    follow_redirect!
    assert_response :success

    assert_equal "+13038947542", @org_profile.phone_number
    assert_equal "Finding pets loving homes across the Denver Metro area", @org_profile.about_us
  end

  test "organization profile does not update with a non valid phone number" do
    patch organization_profile_path(@org_profile), params: {
      organization_profile: {
        phone_number: "303894754232849320"
      }
    }
    @org_profile.reload
    assert_response :unprocessable_entity
    assert_select "div.alert.alert-danger.mt-1", text: "Please fix the errors highlighted below."
  end

  test "organization profile does not update with an invalid email" do
    patch organization_profile_path(@org_profile), params: {
      organization_profile: {
        email: "happy_pets_bad_email.com"
      }
    }
    @org_profile.reload
    assert_response :unprocessable_entity
    assert_select "div.alert.alert-danger.mt-1", text: "Please fix the errors highlighted below."
  end
end
