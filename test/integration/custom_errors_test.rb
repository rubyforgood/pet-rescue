require "test_helper"

class CustomErrorsTest < ActionDispatch::IntegrationTest
  
  test "error code, error message and link to home are displayed for status 404" do
    get '/404'

    assert_select 'h1', '404: Page not found'
    assert_select 'a', 'Take me home!'
  end

  test "error code, error message and link to home are displayed for status 422" do
    get '/422'

    assert_select 'h1', '422: Restricted Access'
    assert_select 'a', 'Take me home!'
  end

  test "error code, error message and link to home are displayed for status 500" do
    get '/500'

    assert_select 'h1', '500: Internal Server Error'
    assert_select 'a', 'Take me home!'
  end
end
