require "test_helper"

class AdoptablePetsIndexTest < ActionDispatch::IntegrationTest
  setup do
    @match = create(:adopter_application, :adoption_pending)
    @pet = @match.pet
    set_organization(@pet.organization)
  end

  test "unauthenticated user can access adoptable pets index" do
    get "/#{@pet.organization.slug}/adoptable_pets"
    check_messages
    assert_select "h1", "Up for adoption"
  end

  test "all unadopted pets show on the pet_index page" do
    get "/#{@pet.organization.slug}/adoptable_pets"
    assert_select "img.card-img-top", {count: @pet_count}
  end

  test "pet name shows adoption pending if it has any applications with that status" do
    get "/#{@pet.organization.slug}/adoptable_pets"
    assert_select "#adoption-status", "Adoption Pending"
  end
end
