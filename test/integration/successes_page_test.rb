require "test_helper"

class SuccessesPageTest < ActionDispatch::IntegrationTest

  # setup do
  # end

  test "successes page can be accessed" do
    get "/successes"
    assert_response :success
  end
end
