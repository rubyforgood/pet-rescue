require "test_helper"
require "action_policy/test_helper"

class Organizations::PageTextsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @org = ActsAsTenant.current_tenant
    admin = create(:staff_admin, organization: @org)
    sign_in admin
    @page_text = create(:page_text, organization: @org)
  end

  context "authorization" do
    include ActionPolicy::TestHelper

    context "#edit" do
      should "be authorized" do
        assert_authorized_to(
          :manage?, @page_text, with: Organizations::PageTextPolicy
        ) do
          get edit_page_text_url(@page_text)
        end
      end
    end

    context "#update" do
      setup do
        @params = {page_text: {hero: "Super Dog", about: "canine caped crusader"}}
      end

      should "be authorized" do
        assert_authorized_to(
          :manage?, @page_text, with: Organizations::PageTextPolicy
        ) do
          patch page_text_url(@page_text), params: @params
        end
      end
    end
  end
  context "GET #edit" do
    should "get edit page" do
      get edit_page_text_path
      assert_response :success
    end
  end

  context "PATCH #update" do
    should "update page text" do
      patch page_text_path(@page_text), params: {page_text: {hero: "Super Dog", about: "canine caped crusader"}}
      @page_text.reload
      assert_response :redirect
      follow_redirect!
      assert_response :success
      assert_equal "Super Dog", @page_text.hero
      assert_equal "canine caped crusader", @page_text.about
    end
  end
end
