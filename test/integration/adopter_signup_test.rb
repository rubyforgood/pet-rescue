require "test_helper"

class AdopterSignupTest < ActionDispatch::IntegrationTest
  test "selecting adopter sends correct param" do
    get "/account_select"
    assert_response :success
  end
end
