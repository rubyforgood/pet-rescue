require "application_system_test_case"

class AdoptionFostererTest < ApplicationSystemTestCase
  setup do
    @user = create(:fosterer, :with_profile)
    @organization = @user.organization
    @page_text = create(:page_text, :with_image, organization: @organization)
    Current.organization = @organization

    @pet = create(:pet)
    create(:adopter_application, :successful_applicant, pet_id: @pet.id)

    sign_in @user
  end

  context "adoption applications" do
    should "should show list of user's adoption applications" do
      visit adopter_fosterer_dashboard_index_path
      click_on "Adoption Applications"
      assert_text "this will fail"
    end
  end
end
