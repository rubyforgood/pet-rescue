require "application_system_test_case"

class HomePageTest < ApplicationSystemTestCase
  setup do
    @user = create(:user)
    @organization = @user.organization
    set_organization(@organization)
  end

  test "renders custom hero and about text from PageText or default text" do
    create(:page_text, hero: "Super Pets for a good paws", about: "All about us")

    visit home_index_path
    assert_text "Super Pets for a good paws"
    assert_text "All about us"

    # Should render the organization location information
    assert_text @organization.location.city_town
    assert_text @organization.location.province_state
    assert_text @organization.location.country
    assert_text @organization.profile.email
    assert_text @organization.profile.phone_number
  end
end
