# frozen_string_literal: true

require "test_helper"

class ApplicationHelperTest < ActionView::TestCase
  context "#organization_home_path" do
    should "return the correct path with the organization slug" do
      organization = create(:organization)

      assert_equal home_index_path(script_name: "/#{organization.slug}"), organization_home_path(organization)
      assert_match(/#{organization.slug}/, organization_home_path(organization))
    end
  end
end
