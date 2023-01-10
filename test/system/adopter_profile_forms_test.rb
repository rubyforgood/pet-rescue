require "application_system_test_case"

class AdopterProfileFormsTest < ApplicationSystemTestCase
  test "Conditional inputs appear after radio check and all text areas have character counter when text is entered" do
    sign_in users(:user_one)
    visit profile_path

    click_on "Edit Profile"
    assert_selector "h1", text: "EDIT PROFILE"

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
end
