require "test_helper"

class RevokeAdoptionTest < ActionDispatch::IntegrationTest
  test "staff can revoke adoption and pet becomes adoptable and successful application set to withdrawn" do
    skip("while new ui is implemented")
    # pet = create(:pet)
    # adopter_account = create(:adopter_account, :with_adopter_foster_profile)
    # adopter_application = create(:adopter_application, adopter_account: adopter_account, pet: pet)
    # create(:match, pet: pet, adopter_account: adopter_account, organization: pet.organization)
    # staff_account = create(:staff_account, organization: pet.organization)
    # user = create(:user, :verified_staff, staff_account: staff_account)
    # sign_in user

    # get "/adoptable_pets"
    # assert_select "h3", {text: pet.name.to_s, count: 0}

    # get "/pets/#{pet.id}"
    # assert_select "p", {text: "Pause Applications?", count: 0}
    # assert_select "a", "Revoke Adoption"

    # delete "/revoke_adoption", params: {match_id: pet.match.id}

    # assert_response :redirect
    # follow_redirect!
    # assert_equal "Adoption reverted & application set to 'Withdrawn'", flash[:notice]

    # get "/pets/#{pet.id}"
    # assert_select "p", "Pause Applications?"
    # assert_select "a", {text: "Revoke Adoption", count: 0}

    # assert_equal "withdrawn", adopter_application.reload.status

    # get "/adoptable_pets"
    # assert_select "h3", pet.name.to_s
  end
end
