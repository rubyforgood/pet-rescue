require "application_system_test_case"

class HomePageTest < ApplicationSystemTestCase
  setup do
    @user = create(:user, :activated_staff)
    @organization = @user.organization
    set_organization(@organization)
  end

  test "renders custom hero and about text from PageText or default text" do
    # PageText.create(hero: "Super Pets for a good paws", about: "All about us")
    patch page_text_path(@page_text), params: {page_text: {hero: "Super Dog", about: "canine caped crusader"}}
    visit home_index_path
    assert_text "Super Pets for a good paws"
    assert_text "All about us"
  end
end
