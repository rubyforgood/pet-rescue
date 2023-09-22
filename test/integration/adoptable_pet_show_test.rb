require "test_helper"

class AdoptablePetShowTest < ActionDispatch::IntegrationTest
  test "unauthenticated users see create account prompt and link" do
    skip("while new ui is implemented")
    # pet = create(:pet)

    # get "/adoptable_pets/#{pet.id}"
  end

  test "adopter without a profile sees complete my profile prompt and link" do
    skip("while new ui is implemented")
    # pet = create(:pet)
    # sign_in create(:user, :adopter_without_profile)

    # get "/adoptable_pets/#{pet.id}"

    # check_messages
    # assert_select "h4", "Complete your profile to apply for this pet"
    # assert_select "a", "Complete my profile"
  end

  test "adopter with a profile sees love this pooch question and apply button" do
    skip("while new ui is implemented")
  #   pet = create(:pet)
  #   sign_in create(:user, :adopter_with_profile)

  #   get "/adoptable_pets/#{pet.id}"

  #   check_messages
  #   assert_select "h4", "In love with this pooch?"
  #   assert_select "form" do
  #     assert_select "button", "Apply to Adopt"
    # end
  end

  test "adopter application sees application status" do
    skip("while new ui is implemented")
    # pet = create(:pet, :adoption_pending)
    # user = create(:user, :application_awaiting_review)
    # user.adopter_account.adopter_applications[0].update(pet: pet)
    # sign_in user

    # get "/adoptable_pets/#{pet.id}"

    # check_messages
    # assert_select "h4.me-2", "Application Awaiting Review"
  end

  test "staff do not see an adopt button only log out button" do
    skip("while new ui is implemented")
    # pet = create(:pet)
    # sign_in create(:user, :verified_staff)

    # get "/adoptable_pets/#{pet.id}"

    # check_messages
    # assert_select "form" do
    #   assert_select "button", "Log Out"
    # end
    # assert_select "form", count: 1
  end

  test "if pet status is paused and reason is opening soon this is displayed" do
    skip("while new ui is implemented")
    # pet = create(:pet, :application_paused_opening_soon)
    # sign_in create(:user, :adopter_with_profile)

    # get "/adoptable_pets/#{pet.id}"

    # assert_select "h3", "Applications Opening Soon"
  end

  test "if pet status is paused and reason is paused until further notice this is displayed" do
    skip("while new ui is implemented")
    # pet = create(:pet, :application_paused_until_further_notice)
    # sign_in create(:user, :adopter_with_profile)

    # get "/adoptable_pets/#{pet.id}"

    # assert_select "h3", "Applications Paused Until Further Notice"
  end

  test "pet name shows adoption pending if it has any applications with that status" do
    skip("while new ui is implemented")
    # pet = create(:pet, :adoption_pending)

    # get "/adoptable_pets/#{pet.id}"

    # check_messages
    # assert_select "h1", "#{pet.name} (Adoption Pending)"
  end

  test "an adopted pet can't be shown as an adoptable pet" do
    skip("while new ui is implemented")
    # adopted_pet = create(:pet, :adopted)

    # get "/adoptable_pets/#{adopted_pet.id}"

    # assert_response :redirect
    # follow_redirect!
    # check_messages
    # assert_equal "You can only view pets that need adoption.", flash[:alert]
  end
end
