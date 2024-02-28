require "test_helper"

class AdopterFosterProfileFormTest < ActionDispatch::IntegrationTest
  test "All errors and their custom messages appear on blank form submission" do
    skip("while new ui is implemented")
    # user = create(:user, :adopter_without_profile)
    # sign_in user

    # post(
    #   "/adopter_foster_profile",
    #   params: {
    #     adopter_foster_profile:
    #       {
    #         adopter_account_id: user.adopter_account.id,
    #         phone_number: "",
    #         contact_method: "",
    #         country: "",
    #         location_attributes: {
    #           province_state: "",
    #           city_town: "",
    #           ideal_pet: "",
    #           id: ""
    #         },
    #         lifestyle_fit: "",
    #         activities: "",
    #         alone_weekday: "",
    #         alone_weekend: "",
    #         experience: "",
    #         contingency_plan: "",
    #         shared_ownership: "",
    #         shared_owner: "",
    #         housing_type: "",
    #         fenced_access: "",
    #         fenced_alternative: "",
    #         location_day: "",
    #         location_night: "",
    #         do_you_rent: "",
    #         pets_allowed: "",
    #         adults_in_home: "",
    #         kids_in_home: "",
    #         other_pets: "",
    #         describe_pets: "",
    #         checked_shelter: "",
    #         surrendered_pet: "",
    #         describe_surrender: "",
    #         annual_cost: "",
    #         visit_laventana: "",
    #         visit_dates: "",
    #         referral_source: ""
    #       },
    #     commit: "Save profile"
    #   }
    # )

    # assert_select "div.alert", {count: 27}
    # assert_select "div.alert" do
    #   assert_select "p", "Please fix the errors highlighted below."
    # end
    # assert_select "div.alert", "Phone number is invalid"
    # assert_select "div.alert", "Contact method can't be blank"
    # assert_select "div.alert", "Please enter a country"
    # assert_select "div.alert", "Please enter a province or state"
    # assert_select "div.alert", "Please enter a city or town"
    # assert_select "div.alert", "Please tell us about your ideal pet"
    # assert_select "div.alert", "Please tell us about your lifestyle"
    # assert_select "div.alert", "Please tell us about the activities"
    # assert_select "div.alert", "This field cannot be blank", 2
    # assert_select "div.alert", "Please tell us about your pet experience"
    # assert_select "div.alert", "Please tell us about your contingencies"
    # assert_select "div.alert", "Select one", 7
    # assert_select "div.alert", "Housing type can't be blank"
    # assert_select "div.alert", "can't be blank", 2
    # assert_select "div.alert", "Adults in home can't be blank"
    # assert_select "div.alert", "Kids in home can't be blank"
    # assert_select "div.alert", "Please provide an annual cost estimate"
    # assert_select "div.alert", "Please tell us how you heard about us"
  end

  test "Phone number with less than 8 digits is invalid" do
    skip("while new ui is implemented")
    # user = create(:user, :adopter_with_profile)
    # sign_in user

    # put(
    #   "/adopter_foster_profile",
    #   params: {
    #     adopter_foster_profile:
    #     {
    #       adopter_account_id: user.adopter_account.id,
    #       phone_number: "1234567"
    #     },
    #     commit: "Save profile"
    #   }
    # )

    # assert_select "div.alert", "Phone number is invalid"
  end

  test "Phone number with more than 10 digits is invalid" do
    skip("while new ui is implemented")
    # user = create(:user, :adopter_with_profile)
    # sign_in user

    # put(
    #   "/adopter_foster_profile",
    #   params: {
    #     adopter_foster_profile:
    #     {
    #       adopter_account_id: user.adopter_account.id,
    #       phone_number: "123456789101112"
    #     },
    #     commit: "Save profile"
    #   }
    # )

    # assert_select "div.alert", "Phone number is invalid"
  end

  test "Radio buttons are pre-populated with adopter selection on edit form" do
    skip("while new ui is implemented")
    # user = create(:user, :adopter_with_profile)
    # sign_in user

    # get "/adopter_foster_profile/edit"

    # a = assert_select "form input[type=radio][id=adopter_foster_profile_shared_ownership_false]"
    # assert_equal a[0].attributes["checked"].value, "checked"
    # a = assert_select "form input[type=radio][id=adopter_foster_profile_fenced_access_true]"
    # assert_equal a[0].attributes["checked"].value, "checked"
    # a = assert_select "form input[type=radio][id=adopter_foster_profile_do_you_rent_false]"
    # assert_equal a[0].attributes["checked"].value, "checked"
    # a = assert_select "form input[type=radio][id=adopter_foster_profile_other_pets_false]"
    # assert_equal a[0].attributes["checked"].value, "checked"
    # a = assert_select "form input[type=radio][id=adopter_foster_profile_checked_shelter_true]"
    # assert_equal a[0].attributes["checked"].value, "checked"
    # a = assert_select "form input[type=radio][id=adopter_foster_profile_surrendered_pet_false]"
    # assert_equal a[0].attributes["checked"].value, "checked"
    # a = assert_select "form input[type=radio][id=adopter_foster_profile_visit_laventana_false]"
    # assert_equal a[0].attributes["checked"].value, "checked"
  end
end
