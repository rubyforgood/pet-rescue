require "application_system_test_case"

class HomePageTest < ApplicationSystemTestCase
  setup do
    @user = create(:user, :activated_staff)
    @organization = @user.organization
    set_organization(@organization)
  end

  test "renders custom hero text from PageText or default text" do
    PageText.create(hero: "Super Pets for a good paws")
    visit home_index_path
    assert_text "Super Pets for a good paws"
  end
end