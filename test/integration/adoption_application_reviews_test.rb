require "test_helper"

class AdoptionApplicationReviewsTest < ActionDispatch::IntegrationTest
  setup do
    @awaiting_review_app = create(:adopter_application, status: :awaiting_review)
    @under_review_app = create(:adopter_application, status: :under_review)
    @adoption_pending_app = create(:adopter_application, :adoption_pending)
    @withdrawn_app = create(:adopter_application, :withdrawn)
    @successful_applicant_app = create(:adopter_application, status: :successful_applicant)
    @adoption_made_app = create(:adopter_application, status: :adoption_made)
  end

  context "non-staff" do
    should "not see any applications" do
      get adoption_application_reviews_path

      assert_response :redirect
      follow_redirect!
      follow_redirect!
      assert_equal "You are not authorized to perform this action.", flash[:alert]
    end
  end

  context "active staff" do
    setup do
      sign_in create(:staff_account).user
    end

    should "see all applications" do
      get adoption_application_reviews_path

      assert_response :success
      AdopterApplication.all.each { |application| verify_application_elements application }
    end

    should "be able to change the application status" do
      patch adoption_application_review_path(@awaiting_review_app.id),
        params: {adopter_application: {status: :under_review}},
        headers: {"HTTP_REFERER" => "example.com"}

      assert_response :redirect
      follow_redirect!
      @awaiting_review_app.reload
      assert_equal "under_review", @awaiting_review_app.status
    end
  end

  context "deactivated staff" do
    setup do
      sign_in create(:staff_account, :deactivated).user
    end

    should_eventually "not see any applications" do
      get adoption_application_reviews_path

      assert_response :redirect
      follow_redirect!
      follow_redirect!
      assert_equal "Unauthorized action.", flash[:alert]
    end
  end

  test "verified staff can add notes to an application" do
    skip("while new ui is implemented")
    # staff_user = create(:user, :verified_staff)
    # adopter_user = create(:adopter, :with_profile)
    # pet = create(:pet, organization: staff_user.staff_account.organization)
    # application = create(:adopter_application, adopter_foster_account: adopter_user.adopter_foster_account, pet: pet)
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

  test "when Successful Applicant is selected, button to Create Adoption shows" do
    skip("while new ui is implemented")
    # staff_user = create(:user, :verified_staff)
    # adopter_user = create(:adopter, :with_profile)
    # pet = create(:pet, organization: staff_user.staff_account.organization)
    # application = create(:adopter_application, adopter_foster_account: adopter_user.adopter_foster_account, pet: pet)
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
    skip("while new ui is implemented")
    # staff_user = create(:user, :verified_staff)
    # adopter_user = create(:adopter, :with_profile)
    # pet = create(:pet, organization: staff_user.staff_account.organization)
    # create(:adopter_application, adopter_foster_account: adopter_user.adopter_foster_account, pet: pet)
    # sign_in staff_user

    # get "/adopter_applications"

    # assert_select "a", {count: 1, text: pet.name}

    # post "/create_adoption", params: {adopter_foster_account_id: adopter_user.adopter_foster_account.id, pet_id: pet.id}

    # assert_equal "Pet successfully adopted.", flash[:notice]

    # get "/adopter_applications"

    # assert_select "a", {count: 0, text: pet.name}
  end

  test "after making the http request to create an adoption, a new Adoption is created" do
    skip("while new ui is implemented")
    # staff_user = create(:user, :verified_staff)
    # adopter_user = create(:adopter, :with_profile)
    # pet = create(:pet, organization: staff_user.staff_account.organization)
    # create(:adopter_application, adopter_foster_account: adopter_user.adopter_foster_account, pet: pet)
    # sign_in staff_user

    # assert_changes "Match.count", from: 0, to: 1 do
    #   post "/create_adoption", params: {adopter_foster_account_id: adopter_user.adopter_foster_account.id, pet_id: pet.id}
    # end
  end

  test "Staff can revert withdraw and remove by an adopter and the application reappears for adopter" do
    skip("while new ui is implemented")
    # staff_user = create(:user, :verified_staff)
    # adopter_user = create(:adopter, :with_profile)
    # pet = create(:pet, organization: staff_user.staff_account.organization)
    # application = create(:adopter_application, adopter_foster_account: adopter_user.adopter_foster_account, pet: pet)
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
    skip("while new ui is implemented")
    # staff_user = create(:user, :unverified_staff)
    # adopter_user = create(:user, :adopter_with_profile)
    # pet = create(:pet, organization: staff_user.staff_account.organization)
    # sign_in staff_user

    # post "/create_adoption", params: {adopter_foster_account_id: adopter_user.adopter_foster_account.id, pet_id: pet.id}

    # assert_response :redirect
    # follow_redirect!
    # assert_equal "Unauthorized action.", flash[:alert]
  end

  test "the filter works to show applications for a given pet and for all pets" do
    skip("while new ui is implemented")
    # staff_user = create(:user, :verified_staff)
    # adopter_user = create(:adopter, :with_profile)
    # pet = create(:pet, organization: staff_user.staff_account.organization)
    # create(:adopter_application, adopter_foster_account: adopter_user.adopter_foster_account, pet: pet)
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

  def verify_application_elements(application)
    assert_select "tr[id='adopter_application_#{application.id}']" do
      adopter = application.adopter_foster_account.user
      assert_select "a", text: "#{adopter.last_name}, #{adopter.first_name}"
      assert_select "button", text: application.status.titleize
    end
  end
end
