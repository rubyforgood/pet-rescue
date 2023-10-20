require "test_helper"

class OrganizationProfileTest < ActiveSupport::TestCase
  context "associations" do
    should belong_to(:organization)
    should belong_to(:location)

    should accept_nested_attributes_for(:location)
  end

  context "callbacks" do
    subject { build(:organization_profile, :with_organization) }

    should "call normalize phone when saving" do
      assert subject.expects(:normalize_phone).at_least_once

      subject.save
    end
  end
end
