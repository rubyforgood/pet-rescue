require "test_helper"

class SuccessesPageTest < ActionDispatch::IntegrationTest
  test "location lat and lon are deviated by google maps data builder" do
    # pet = create(:pet, :adopted)
    # location = pet.match.adopter_account.adopter_profile.location

    # get "/successes"
    # assert_response :success

    # list_element = css_select("li[data-lat]").first
    # lat_value = list_element["data-lat"].to_f
    # list_element = css_select("li[data-lon]").first
    # lon_value = list_element["data-lon"].to_f
    # name_value = list_element["data-name"]
    # breed_value = list_element["data-breed"]

    # assert_not_equal(lat_value, location.latitude)
    # assert_not_equal(lon_value, location.longitude)
    # assert_equal(name_value, pet.name)
    # assert_equal(breed_value, pet.breed)
  end

  test "An additional list element is created when a new adoption is made" do
    # user = create(:user, :verified_staff)
    # pet = create(:pet, organization: user.staff_account.organization)
    # adopter_account = create(:user, :adopter_with_profile).adopter_account
    # sign_in user

    # post "/create_adoption",
    #   params: {adopter_account_id: adopter_account.id, pet_id: pet.id}

    # get "/successes"
    # assert_select "ul.coordinates" do
    #   assert_select "li", {count: 1}
    #   assert_select "li[data-lat]", {count: 1}
    #   assert_select "li[data-lon]", {count: 1}
    # end
  end
end
