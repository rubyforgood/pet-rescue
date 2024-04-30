require "test_helper"

class Organizations::HomeControllerTest < ActionDispatch::IntegrationTest
  setup do
    @organization = create(:organization, :with_page_text)
    @organization.save
    Current.organization = @organization
  end

  context "GET #index" do
    should "render index template" do
      get home_index_path(script_name: "/#{@organization.slug}")

      assert_response :success
      assert_select "title", text: "#{@organization.name} | \"Pet Rescue\""
    end
  end
end
