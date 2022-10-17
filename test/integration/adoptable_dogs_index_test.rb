require "test_helper"

class AdoptableDogsIndexTest < ActionDispatch::IntegrationTest

  test "unauthenticated user can access adoptable dogs index" do
    get "/adoptable_dogs"
    assert_response :success
    assert_select "h1", "Up for adoption"
  end
end
