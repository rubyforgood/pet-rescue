require "test_helper"

class AdoptionApplicationReviewsTest < ActionDispatch::IntegrationTest
  test "verified staff can see all applications" do
    # user = create(:user, :verified_staff)
    # sign_in user

    # get "/adopter_applications"

    # assert_response :success
    # assert_select "a", {
    #   count: Pet.org_pets_with_apps(user.staff_account.organization_id).count, text: "Adopter Profile"
    # }
  end

  test "unverified staff cannot access the page" do
    # user = create(:user, :unverified_staff)
    # sign_in user

    # get "/adopter_applications"

    # assert_response :redirect
    # follow_redirect!
    # assert_equal "Unauthorized action.", flash[:alert]
  end

  test "all expected elements of an application are shown" do
    # staff_user = create(:user, :verified_staff)
    # adopter_user = create(:user, :adopter_with_profile)
    # pet = create(:pet, organization: staff_user.staff_account.organization)
    # application = create(:adopter_application, adopter_account: adopter_user.adopter_account, pet: pet)
    # sign_in staff_user

    # get "/adopter_applications"

    # assert_select "a", application.pet.name
    # assert_select "p", "Applicant: #{adopter_user.first_name} #{adopter_user.last_name}"
    # assert_select "a", "Adopter Profile"
    # assert_select "a", "Edit Application"
  end

  test "verified staff can edit an adoption application status" do
    staff_user = create(:user, :verified_staff)
    adopter_user = create(:user, :adopter_with_profile)
    pet = create(:pet, organization: staff_user.staff_account.organization)
    application = create(:adopter_application, adopter_account: adopter_user.adopter_account, status: 0, pet: pet)
    sign_in staff_user

    assert_changes "AdopterApplication.find(application.id).status", from: "awaiting_review", to: "under_review" do
      put(
        "/adopter_applications/#{application.id}",
        params: {
          adopter_application:
            {status: "under_review", notes: ""},
          commit: "Save",
          id: application.id
        }
      )
    end
  end

  test "unverified staff cannot edit an adoption application status" do
    # staff_user = create(:user, :unverified_staff)
    # application = create(:adopter_application)
    # sign_in staff_user

    # put(
    #   "/adopter_applications/#{application.id}",
    #   params: {
    #     adopter_application:
    #       {status: "under_review", notes: ""},
    #     commit: "Save",
    #     id: application.id
    #   }
    # )

    # assert_response :redirect
    # follow_redirect!
    # assert_equal "Unauthorized action.", flash[:alert]
  end

  test "verified staff can add notes to an application" do
    # staff_user = create(:user, :verified_staff)
    # adopter_user = create(:user, :adopter_with_profile)
    # pet = create(:pet, organization: staff_user.staff_account.organization)
    # application = create(:adopter_application, adopter_account: adopter_user.adopter_account, pet: pet)
    # sign_in staff_user

    # put(
    #   "/adopter_applications/#{application.id}",
    #   params: {
    #     adopter_application:
    #       {
    #         status: "under_review", notes: "some notes"
    #       },
    #     commit: "Save",
    #     id: application.id
    #   }
    # )

    # assert_response :redirect

    # get "/adopter_applications/#{application.id}/edit"

    # assert_select "textarea", "some notes"
  end

  test "unverified staff cannot add notes to an application" do
    # staff_user = create(:user, :unverified_staff)
    # application = create(:adopter_application)
    # sign_in staff_user

    # put(
    #   "/adopter_applications/#{application.id}",
    #   params: {
    #     adopter_application:
    #       {
    #         status: "under_review", notes: "some notes"
    #       },
    #     commit: "Save",
    #     id: application.id
    #   }
    # )

    # assert_response :redirect
    # follow_redirect!
    # assert_equal "Unauthorized action.", flash[:alert]
  end

  test "when Successful Applicant is selected, button to Create Adoption shows" do
    # staff_user = create(:user, :verified_staff)
    # adopter_user = create(:user, :adopter_with_profile)
    # pet = create(:pet, organization: staff_user.staff_account.organization)
    # application = create(:adopter_application, adopter_account: adopter_user.adopter_account, pet: pet)
    # sign_in staff_user

    # put(
    #   "/adopter_applications/#{application.id}",
    #   params: {
    #     adopter_application:
    #       {
    #         status: "successful_applicant", notes: ""
    #       },
    #     commit: "Save",
    #     id: application.id
    #   }
    # )

    # follow_redirect!
    # assert_select "a", "Create Adoption"
  end

  test "after making the http request to create an adoption, the application disappears" do
    # staff_user = create(:user, :verified_staff)
    # adopter_user = create(:user, :adopter_with_profile)
    # pet = create(:pet, organization: staff_user.staff_account.organization)
    # create(:adopter_application, adopter_account: adopter_user.adopter_account, pet: pet)
    # sign_in staff_user

    # get "/adopter_applications"

    # assert_select "a", {count: 1, text: pet.name}

    # post "/create_adoption", params: {adopter_account_id: adopter_user.adopter_account.id, pet_id: pet.id}

    # assert_equal "Pet successfully adopted.", flash[:notice]

    # get "/adopter_applications"

    # assert_select "a", {count: 0, text: pet.name}
  end

  test "after making the http request to create an adoption, a new Adoption is created" do
    staff_user = create(:user, :verified_staff)
    adopter_user = create(:user, :adopter_with_profile)
    pet = create(:pet, organization: staff_user.staff_account.organization)
    create(:adopter_application, adopter_account: adopter_user.adopter_account, pet: pet)
    sign_in staff_user

    assert_changes "Match.count", from: 0, to: 1 do
      post "/create_adoption", params: {adopter_account_id: adopter_user.adopter_account.id, pet_id: pet.id}
    end
  end

  test "Staff can revert withdraw and remove by an adopter and the application reappears for adopter" do
    # staff_user = create(:user, :verified_staff)
    # adopter_user = create(:user, :adopter_with_profile)
    # pet = create(:pet, organization: staff_user.staff_account.organization)
    # application = create(:adopter_application, adopter_account: adopter_user.adopter_account, pet: pet)
    # sign_in adopter_user

    # patch "/my_application", params: {application: {id: application.id, status: "withdrawn"}}
    # patch "/my_application", params: {application: {id: application.id, profile_show: "false"}}

    # assert_select "h3", {count: 0, text: pet.name}

    # sign_in staff_user

    # patch(
    #   "/adopter_applications/#{application.id}",
    #   params: {
    #     adopter_application:
    #       {
    #         status: "under_review", notes: "", profile_show: "true"
    #       },
    #     commit: "Save",
    #     id: application.id
    #   }
    # )

    # sign_in adopter_user

    # get "/my_applications"

    # assert_select "h3", {count: 1, text: pet.name}
  end

  test "unverified staff cannot create an adoption" do
    # staff_user = create(:user, :unverified_staff)
    # adopter_user = create(:user, :adopter_with_profile)
    # pet = create(:pet, organization: staff_user.staff_account.organization)
    # sign_in staff_user

    # post "/create_adoption", params: {adopter_account_id: adopter_user.adopter_account.id, pet_id: pet.id}

    # assert_response :redirect
    # follow_redirect!
    # assert_equal "Unauthorized action.", flash[:alert]
  end

  test "the filter works to show applications for a given pet and for all pets" do
    # staff_user = create(:user, :verified_staff)
    # adopter_user = create(:user, :adopter_with_profile)
    # pet = create(:pet, organization: staff_user.staff_account.organization)
    # create(:adopter_application, adopter_account: adopter_user.adopter_account, pet: pet)
    # sign_in staff_user

    # get "/adopter_applications"

    # assert_select(
    #   "div.card",
    #   # count of all unadopted pets with an application for a given org
    #   {count: Pet.org_pets_with_apps(staff_user.staff_account.organization_id).count}
    # )

    # get "/adopter_applications", params: {pet_id: pet.id}

    # assert_select "div.card", {count: 1}
    # assert_select "h4", pet.name.to_s

    # get "/adopter_applications", params: {pet_id: ""}

    # assert_select(
    #   "div.card",
    #   {count: Pet.org_pets_with_apps(staff_user.staff_account.organization_id).count}
    # )
  end
end
