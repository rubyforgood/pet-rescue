require "test_helper"

class RevokeAdoptionTest < ActionDispatch::IntegrationTest

  setup do 
    sign_in users(:verified_staff_one)
    @pet = pets(:adopted_pet)
    @adoption_id = Adoption.find_by(pet_id: @pet.id).id
    @successful_application = adopter_applications(:adopter_application_three)
  end

  test "staff can revoke adoption and pet becomes adoptable and successful application set to withdrawn" do
    get "/adoptable_pets"
    assert_select "h3", { text: "#{@pet.name}", count: 0 }

    get "/pets/#{@pet.id}"
    assert_select "p", { text: "Pause Applications?", count: 0 }
    assert_select "a", "Revoke Adoption"
    
    delete "/revoke_adoption",
      params: { adoption_id: @adoption_id }
    
    assert_response :redirect
    follow_redirect!
    assert_equal "Adoption reverted & application set to 'Withdrawn'", flash[:notice]

    get "/pets/#{@pet.id}"
    assert_select "p", "Pause Applications?"
    assert_select "a", { text: "Revoke Adoption", count: 0 }

    assert_equal "withdrawn", @successful_application.status

    get "/adoptable_pets"
    assert_select "h3", "#{@pet.name}"
  end

end
