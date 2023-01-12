require "application_system_test_case"

class AdopterProfileFormsTest < ApplicationSystemTestCase

  setup do
    sign_in users(:user_one)
    visit profile_path

    click_on "Edit Profile"
    assert_selector "h1", text: "EDIT PROFILE"
  end

  test "Conditional inputs appear after radio check and all text areas have character counter when text is entered" do
    fill_in "Briefly describe your ideal dog", with: "Big and fluffy."
    fill_in "Briefly describe your lifestyle", with: "Big and fluffy."
    fill_in "Briefly describe activities you will do with your dog", with: "Big and fluffy."
    fill_in "Briefly describe your dog care experience", with: "Big and fluffy."
    fill_in "Who will care for your dog during emergencies or vacations?", with: "Big and fluffy."

    find("label[for=adopter_profile_other_pets_true]").click
    find("label[for=adopter_profile_shared_ownership_true]").click
    find("label[for=adopter_profile_fenced_access_false]").click

    fill_in "How do you plan to care for the dog without a fenced garden?", with: "Big and fluffy."
    fill_in "List pets (include neuter status if dog)", with: "Big and fluffy."
    fill_in "Briefly describe who else will share dog ownership", with: "Big and fluffy."

    assert_selector "div.small", text: "15/200", count: 8
  end

  test "Check all dropdowns contain all exptected values" do 
    assert_equal page.all('select#adopter_profile_contact_method option').map(&:value), %w(Phone Email WhatsApp)
    assert_equal page.all('select#adopter_profile_alone_weekday option').map(&:value), %w[0 1 2 3 4 5 6 7 8 9 10]
    assert_equal page.all('select#adopter_profile_alone_weekend option').map(&:value), %w[0 1 2 3 4 5 6 7 8 9 10]
    assert_equal page.all('select#adopter_profile_housing_type option').map(&:value), %w(Acreage Detached Duplex Apartment Trailer)
    assert_equal page.all('select#adopter_profile_adults_in_home option').map(&:value), %w[1 2 3 4 5 6 7 8 9 10]
    assert_equal page.all('select#adopter_profile_kids_in_home option').map(&:value), %w[0 1 2 3 4 5 6 7 8 9 10]
  end
end
