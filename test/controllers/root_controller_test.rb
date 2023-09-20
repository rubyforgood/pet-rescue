require 'test_helper'

class RootsControllerTest < ActionDispatch::IntegrationTest

  context "GET #index" do
    should "get the root url" do
      get root_url

      assert_response :success
    end

    context "when there is a current organization" do
      setup do
        Current.stubs(:organization).returns('something')
      end

      should "redirect to the home page" do
        get root_url

        assert_redirected_to home_index_url
      end
    end

    context "when there is not a current organization" do
      setup do
        Current.stubs(:organization).returns(nil)
      end

      should "not redirect to the home page and render the index template" do
        get root_url

        assert_response :success
      end
    end
  end

end

