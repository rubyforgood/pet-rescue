require "application_system_test_case"

class AdopterProfileFormsTest < ApplicationSystemTestCase

  setup do
    sign_in users(:adopter_with_profile)
    visit profile_path
    click_on "Edit Profile"
  end

  test "Text areas appear after radio check and all text areas have character counter and text areas disappear after radio check" do
    assert_selector "h1", text: "EDIT PROFILE"

    fill_in "Briefly describe your ideal dog", with: "Big and fluffy."
    fill_in "Briefly describe your lifestyle", with: "Big and fluffy."
    fill_in "Briefly describe activities you will do with your dog", with: "Big and fluffy."
    fill_in "Briefly describe your dog care experience", with: "Big and fluffy."
    fill_in "Who will care for your dog during emergencies or vacations?", with: "Big and fluffy."

    find("label[for=adopter_profile_other_pets_true]").click
    find("label[for=adopter_profile_shared_ownership_true]").click
    find("label[for=adopter_profile_fenced_access_false]").click
    find("label[for=adopter_profile_surrendered_pet_true]").click

    fill_in "How do you plan to care for the dog without a fenced garden?", with: "Big and fluffy."
    fill_in "List pets (include neuter status if dog)", with: "Big and fluffy."
    fill_in "Briefly describe who else will share dog ownership", with: "Big and fluffy."
    fill_in "Briefly describe the circumstances around surrenderring or rehoming the pet", with: "Big and fluffy."

    assert_selector "div.small", text: "15/200", count: 9
    assert_selector "textarea", count: 9

    find("label[for=adopter_profile_other_pets_false]").click
    find("label[for=adopter_profile_shared_ownership_false]").click
    find("label[for=adopter_profile_fenced_access_true]").click
    find("label[for=adopter_profile_surrendered_pet_false]").click

    assert_selector "textarea", count: 5
  end

  test "Check all dropdowns contain all exptected values" do 
    assert_equal page.all('select#adopter_profile_contact_method option').map(&:value), %w(Phone Email WhatsApp)
    assert_equal page.all('select#adopter_profile_alone_weekday option').map(&:value), %w[0 1 2 3 4 5 6 7 8 9 10]
    assert_equal page.all('select#adopter_profile_alone_weekend option').map(&:value), %w[0 1 2 3 4 5 6 7 8 9 10]
    assert_equal page.all('select#adopter_profile_housing_type option').map(&:value), %w(Acreage Detached Duplex Apartment Trailer)
    assert_equal page.all('select#adopter_profile_adults_in_home option').map(&:value), %w[1 2 3 4 5 6 7 8 9 10]
    assert_equal page.all('select#adopter_profile_kids_in_home option').map(&:value), %w[0 1 2 3 4 5 6 7 8 9 10]
  end

  test "Dropdowns populate with the users values when editing profile" do 
    assert_equal page.all('select#adopter_profile_contact_method').map(&:value).join, 'Phone'
    assert_equal page.all('select#adopter_profile_alone_weekday').map(&:value).join, '3'
    assert_equal page.all('select#adopter_profile_alone_weekend').map(&:value).join, '3'
    assert_equal page.all('select#adopter_profile_housing_type').map(&:value).join, 'Detached'
    assert_equal page.all('select#adopter_profile_adults_in_home').map(&:value).join, '2'
    assert_equal page.all('select#adopter_profile_kids_in_home').map(&:value).join, '2'
  end
end
