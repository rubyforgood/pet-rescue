require "test_helper"

class Organizations::PageTextsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @org = ActsAsTenant.current_tenant
    admin = create(:user, :staff_admin, organization: @org)
    sign_in admin
    @page_text = create(:page_text, organization: @org)
  end

  context "GET #edit" do
    should "get edit page" do
      get edit_page_text_path
      assert_response :success
    end
  end

  context "PATCH #update" do
    should "update page text" do
      patch page_text_path(@page_text), params: { page_text: { hero: "Super Dog", about: "canine caped crusader" } }
      assert_response :redirect
      follow_redirect!
      assert_response :success
      assert_equal "Super Dog", @page_text.hero
      assert_equal "canine caped crusader", @page_text.about
    end
  end
end
