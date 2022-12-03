require "test_helper"

class AdoptableDogsIndexTest < ActionDispatch::IntegrationTest

  # all unadopted dogs under all organizations
  dog_count = Dog.includes(:adoption).where(adoption: { id: nil }).length

  test "unauthenticated user can access adoptable dogs index" do
    get "/adoptable_dogs"
    assert_response :success
    assert_select "h1", "Up for adoption"
  end

  test "all unadopted dogs show on the dog_index page" do
    get '/adoptable_dogs'
    assert_select 'img.card-img-top', { count: dog_count }
  end

end
