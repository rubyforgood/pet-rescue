require "test_helper"

class CTATest < ActionDispatch::IntegrationTest
  test "homepage CTA section above footer exists when unauthenticated" do
    get "/"
    assert_select "section#cta"
  end

  test "homepage CTA section above footer does not exists when authenticated" do
    sign_in create(:user, :adopter_with_profile)
    get "/"
    assert_select "section#cta", false
  end
end
