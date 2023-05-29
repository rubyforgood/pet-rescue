require "test_helper"

class RevokeAdoptionTest < ActionDispatch::IntegrationTest

  setup do 
    sign_in users(:verified_staff_one)
    @dog = dogs(:adopted_dog)
    @adoption_id = Adoption.find_by(dog_id: @dog.id).id
    @successful_application = adopter_applications(:adopter_application_three)
  end

  test "staff can revoke adoption and dog becomes adoptable and successful application set to withdrawn" do
    get "/adoptable_dogs"
    assert_select "h3", { text: "#{@dog.name}", count: 0 }

    get "/dogs/#{@dog.id}"
    assert_select "p", { text: "Pause Applications?", count: 0 }
    assert_select "a", "Revoke Adoption"
    
    delete "/revoke_adoption",
      params: { adoption_id: @adoption_id }
    
    assert_response :redirect
    follow_redirect!
    assert_equal "Adoption reverted & application set to 'Withdrawn'", flash[:notice]

    get "/dogs/#{@dog.id}"
    assert_select "p", "Pause Applications?"
    assert_select "a", { text: "Revoke Adoption", count: 0 }

    assert_equal "withdrawn", @successful_application.status

    get "/adoptable_dogs"
    assert_select "h3", "#{@dog.name}"
  end

end
