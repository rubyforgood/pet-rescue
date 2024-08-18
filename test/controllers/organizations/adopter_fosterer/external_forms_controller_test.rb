require "test_helper"

class ExternalFormsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get external_forms_index_url
    assert_response :success
  end
end
