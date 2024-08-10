require "test_helper"

class Organizations::AdopterFosterer::AdoptedPetTest < ActionDispatch::IntegrationTest
  setup do
    @organization = ActsAsTenant.current_tenant
    @adopter_foster_account = create(:adopter_foster_account)
    @pet = create(:pet, :with_files)
    @adoption_application = create(:adopter_application, status: :adoption_made, pet: @pet, adopter_foster_account: @adopter_foster_account)
    sign_in @adopter_foster_account.user
  end

  test "index action should show adopted pets" do
    get adopter_fosterer_adopted_pets_path
    assert_response :success
    assert_select "a", text: @pet.name
  end

  test "files action should render the pet files partial" do
    assert @pet.files.attached?

    get files_adopter_fosterer_adopted_pet_path(@pet), as: :turbo_stream
    assert_response :success

    assert_select 'turbo-stream[action="replace"][target="pet_files"]' do
      assert_select "table tbody tr" do |rows|
        filenames = @pet.files.map(&:filename).map(&:to_s)
        rows.each_with_index do |row, index|
          assert_select row, "td:first-child a", filenames[index]
        end
      end
    end
  end

  test "files action should return an empty table if no files are attached" do
    @pet.files.purge
    get files_adopter_fosterer_adopted_pet_path(@pet), as: :turbo_stream
    assert_response :success
    assert_select "table" do
      assert_select "tbody tr", count: 1
      assert_select "td", text: "No files attached."
    end
  end
end
