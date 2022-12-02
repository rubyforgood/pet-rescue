require "test_helper"

class ErrorsControllerTest < ActionDispatch::IntegrationTest
  test "should get not_found" do
    get '/404'
    assert_response :success
  end

  test "should get internal_server_error" do
    get '/500'
    assert_response :success
  end

  test "should get restricted_access" do
    get '/422'
    assert_response :success
  end
end
