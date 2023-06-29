require "test_helper"

class SuccessesControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get successes_url
    assert_response :success
  end
end
