require "test_helper"

class AdoptablePetsIndexTest < ActionDispatch::IntegrationTest
  setup do
    @available_pet = create(:pet)
    @pet_in_draft = create(:pet, published: false)
    @pet_pending_adoption = create(:pet, :adoption_pending)
    @adopted_pet = create(:pet, :adopted)
  end

  teardown do
    check_messages
  end

  test "unauthenticated user can access adoptable pets index" do
    get adoptable_pets_path

    assert_select "h1", "Up for adoption"
    assert_response :success
    assert_select "a[href$='adoptable_pets/#{@available_pet.id}']", 2
    assert_select "a[href$='adoptable_pets/#{@pet_in_draft.id}']", 0
    assert_select "a[href$='adoptable_pets/#{@pet_pending_adoption.id}']", 2
    assert_select "a[href$='adoptable_pets/#{@adopted_pet.id}']", 0
  end
end
