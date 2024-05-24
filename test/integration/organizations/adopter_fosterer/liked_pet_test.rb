require "test_helper"

class Organizations::AdopterFosterer::LikedPetTest < ActionDispatch::IntegrationTest
  setup do
    @pet = create(:pet)
    @user = create(:adopter)
    sign_in @user
  end

  test "adopter can like a pet" do
    assert_difference "LikedPet.count", 1 do
      post adopter_fosterer_liked_pets_path,
        params: {liked_pet: {pet_id: @pet.id}},
        headers: {"HTTP_REFERER" => "http://www.example.com/"}
    end
  end

  test "adopter can unlike a pet" do
    @liked_pet = create(:liked_pet, adopter_foster_account_id: @user.adopter_foster_account.id, pet_id: @pet.id)
    assert_difference "LikedPet.count", -1 do
      delete adopter_fosterer_liked_pet_path(@liked_pet), headers: {"HTTP_REFERER" => "http://www.example.com/"}
    end
  end
end
