require "test_helper"

class AdoptablePetShowTest < ActionDispatch::IntegrationTest
  setup do
    @available_pet = create(:pet)
    set_organization(@available_pet.organization)
    @pet_in_draft = create(:pet, published: false)
    @pet_pending_adoption = create(:pet, :adoption_pending)
    @adopted_pet = create(:pet, :adopted)
    @staff_user = create(:staff_account).user
    @adopter_user = create(:adopter_account).user
    create(:adopter_foster_profile, adopter_account: @adopter_user.adopter_account)
  end

  teardown do
    check_messages
    :after_teardown
  end

  test "unauthenticated users can see an available pet" do
    get adoptable_pet_path(@available_pet)

    assert_response :success
    assert_cannot_apply_to_adopt
  end

  test "unauthenticated users can see a pet with a pending adoption" do
    get adoptable_pet_path(@pet_pending_adoption)

    assert_response :success
  end

  test "unauthenticated users cannot see an unpublished pet" do
    get adoptable_pet_path(@pet_in_draft)

    assert_response :redirect
  end

  test "unauthenticated users cannot see an adopted pet" do
    get adoptable_pet_path(@adopted_pet)

    assert_response :redirect
  end

  test "staff can see an available pet" do
    sign_in @staff_user
    get adoptable_pet_path(@available_pet)

    assert_response :success
  end

  test "staff can see a pet with a pending adoption" do
    sign_in @staff_user
    get adoptable_pet_path(@pet_pending_adoption)

    assert_response :success
    assert_cannot_apply_to_adopt
  end

  test "staff cannot see an unpublished pet" do
    sign_in @staff_user
    get adoptable_pet_path(@pet_in_draft)

    assert_response :redirect
  end

  test "staff cannot see an adopted pet" do
    sign_in @staff_user
    get adoptable_pet_path(@adopted_pet)

    assert_response :redirect
  end

  test "adopter can see and apply to an available pet" do
    sign_in @adopter_user
    get adoptable_pet_path(@available_pet)

    assert_response :success
    assert_can_apply_to_adopt
  end

  test "adopter can see a pet with a pending adoption" do
    sign_in @adopter_user
    get adoptable_pet_path(@pet_pending_adoption)

    assert_response :success
  end

  test "adopter cannot see an unpublished pet" do
    sign_in @adopter_user
    get adoptable_pet_path(@pet_in_draft)

    assert_response :redirect
  end

  test "adopter cannot see an adopted pet" do
    sign_in @adopter_user
    get adoptable_pet_path(@adopted_pet)

    assert_response :redirect
  end

  test "adopter application sees application status" do
    skip("while new ui is implemented")
    # pet = create(:pet, :adoption_pending)
    # user = create(:user, :adopter_with_profile, organization: pet.organization)
    # create(:adopter_application, adopter_account: user.adopter_account, pet: pet, status: :awaiting_review)
    # sign_in user

    # get "/adoptable_pets/#{pet.id}"

    # check_messages
    # assert_select "h4.me-2", "Application Awaiting Review"
  end

  test "pet name shows adoption pending if it has any applications with that status" do
    skip("while new ui is implemented")
    # pet = create(:pet, :adoption_pending)

    # get "/adoptable_pets/#{pet.id}"

    # check_messages
    # assert_select "h1", "#{pet.name} (Adoption Pending)"
  end

  def assert_can_apply_to_adopt
    assert_select "input[type='submit']", value: "Apply to Adopt"
  end

  def assert_cannot_apply_to_adopt
    assert_select "input[type='submit']", value: "Apply to Adopt", count: 0
  end
end
