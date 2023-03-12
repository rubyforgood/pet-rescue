require "test_helper"

class RevokeAdoptionTest < ActionDispatch::IntegrationTest

  setup do 
    sign_in users(:user_two)
  end

  # go to org dogs show page for an adopted dog
  test "staff can revoke adoption and dog becomes adoptable and application is set to withdrawn" do
    get "/dogs/#{dogs(:dog_two).id}"

    # assert no pause app box
    assert_select "p", { text: "Pause Applications?", count: 0 }
    # assert revoke adoption button
    assert_select "a", "Revoke Adoption"
    

  # submit the request to revoke the adoption
  # assert flash stating adoption was revoked
  # assert no revoke adoption button
  # assert pause app box

  # check successful app status was set to withdrawn

  end

end