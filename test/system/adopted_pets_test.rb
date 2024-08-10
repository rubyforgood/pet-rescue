require "application_system_test_case"

class AdoptedPetsTest < ApplicationSystemTestCase
  setup do
    @adopter_foster_account = create(:adopter_foster_account)
    @pet = create(:pet, :with_files)
    @adoption_application = create(:adopter_application, status: :adoption_made, pet: @pet, adopter_foster_account: @adopter_foster_account)
    @other_adopter_foster_account = create(:adopter_foster_account)
    @other_pet = create(:pet, :with_files)
    @other_adoption_application = create(:adopter_application, status: :adoption_made, pet: @other_pet, adopter_foster_account: @other_adopter_foster_account)

    sign_in @adopter_foster_account.user
  end

  test "adopter can view their adopted pets and download files" do
    visit adopter_fosterer_adopted_pets_path

    assert_text @pet.name
    refute_text @other_pet.name

    click_on @pet.name

    assert_selector "table" do
      assert_selector "tbody tr", count: @pet.files.count
    end
  end
end
