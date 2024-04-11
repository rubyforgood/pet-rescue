require "test_helper"

class OrganizationProfileTest < ActiveSupport::TestCase
  context "associations" do
    should belong_to(:location)
    should accept_nested_attributes_for(:location)
  end

  test "should belong to an organization" do
    organization_profile = build(:organization_profile)

    assert_equal organization_profile.organization.slug, "test"
  end

  context "validations" do
    should allow_value("123-456-7890").for(:phone_number)
    should allow_value("").for(:phone_number)
    should_not allow_value("invalid_number").for(:phone_number)

    should allow_value("i_love_pets365@gmail.com").for(:email)
    should_not allow_value("invalid_email.com").for(:email)

    should allow_value("https://something.com").for(:facebook_url)
    should allow_value("").for(:facebook_url)
    should_not allow_value("http://something.com").for(:facebook_url)

    should allow_value("https://something.com").for(:instagram_url)
    should allow_value("").for(:instagram_url)
    should_not allow_value("http://something.com").for(:instagram_url)

    should allow_value("https://something.com").for(:donation_url)
    should allow_value("").for(:donation_url)
    should_not allow_value("http://something.com").for(:donation_url)
  end

  context "callbacks" do
    subject { build(:organization_profile) }

    should "call normalize phone when saving" do
      assert subject.expects(:normalize_phone).at_least_once

      subject.save
    end
  end
end
