require "test_helper"

class NavbarTest < ActionDispatch::IntegrationTest

  test "homepage CTA section above footer exists when unauthenticated" do
    get '/'
    assert_select 'section#cta'
  end

  test "homepage CTA section above footer does not exists when authenticated" do
    sign_in users(:user_one)
    get '/'
    assert_select 'section#cta', false
  end

end
