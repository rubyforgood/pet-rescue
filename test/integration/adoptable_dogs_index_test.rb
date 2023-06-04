require "test_helper"

class AdoptableDogsIndexTest < ActionDispatch::IntegrationTest

  # all unadopted dogs under all organizations
  setup do
    @dog_count = Dog.includes(:adoption).where(adoption: { id: nil }).length
  end

  test "unauthenticated user can access adoptable dogs index" do
    get "/adoptable_dogs"
    assert_response :success
    assert_select "h1", "Up for adoption"
  end

  test "all unadopted dogs show on the dog_index page" do
    get '/adoptable_dogs'
    assert_select 'img.card-img-top', { count: @dog_count }
  end

  test "dog name shows adoption pending if it has any applications with that status" do 
    get '/adoptable_dogs'
    assert_select 'h3', "#{dogs(:pending_adoption_one).name} (Adoption Pending)"
  end
end
