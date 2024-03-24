require "test_helper"

class AdopterApplicationsPageTest < ActionDispatch::IntegrationTest
  test "Adopter without profile cannot access adopter applications route" do
    skip("while new ui is implemented")
    # sign_in create(:adopter)

    # get "/my_applications"

    # assert_response :redirect
    # follow_redirect!
    # assert_equal "Unauthorized action.", flash[:alert]
  end

  test "Adopter with profile can access adopter applications route and see applications" do
    skip("while new ui is implemented")
    # pet_name = "Bob"
    # user = create(:adopter, :with_profile)
    # pet = create(:pet, name: pet_name)
    # create(
    #   :adopter_application,
    #   status: 0,
    #   adopter_foster_account: user.adopter_foster_account,
    #   pet: pet
    # )
    # sign_in user

    # get "/my_applications"

    # assert_response :success
    # assert_select "h1", "Adoption Applications"
    # assert_select "form", 2
    # assert_select "form" do
    #   assert_select "button", "Withdraw"
    # end
    # assert_select "h3", pet_name
  end

  test "Adopter with account can withdraw an application and see remove button" do
    skip("while new ui is implemented")
    # user = create(:adopter, :with_profile)
    # application = create(:adopter_application, status: 0, adopter_foster_account: user.adopter_foster_account)
    # sign_in user

    # patch(
    #   "/my_application",
    #   params: {application: {id: application.id, status: "withdrawn"}}
    # )

    # assert_response :redirect
    # follow_redirect!
    # assert_select "h1", "Adoption Applications"
    # assert_select "form", 2
    # assert_select "form" do |forms|
    #   assert_select forms[0], "button", "Log Out"
    #   assert_select forms[1], "button", "Remove"
    # end
  end

  test "Adopter with account can remove an application from the page" do
    skip("while new ui is implemented")
    # user = create(:adopter, :with_profile)
    # application = create(:adopter_application, status: 0, adopter_foster_account: user.adopter_foster_account)
    # sign_in user

    # patch(
    #   "/my_application",
    #   params: {application: {id: application.id, profile_show: "false"}}
    # )

    # assert_response :redirect
    # follow_redirect!
    # assert_select "h1", "Adoption Applications"
    # assert_select "form", 1
    # assert_select "form" do
    #   assert_select "button", "Log Out"
    # end
  end

  test "Adoption status changes when the application status changes" do
    skip("while new ui is implemented")
    # user = create(:adopter, :with_profile)
    # verified_staff = create(:user, :verified_staff)
    # pet = create(:pet, organization: verified_staff.staff_account.organization)
    # application = create(
    #   :adopter_application,
    #   status: 0,
    #   adopter_foster_account: user.adopter_foster_account,
    #   pet: pet
    # )
    # sign_in user

    # get "/my_applications"
    # assert_response :success
    # assert_select "p", "Status: Awaiting Review"

    # logout
    # sign_in verified_staff

    # patch(
    #   "/adopter_applications/#{application.id}",
    #   params: {adopter_application: {status: "adoption_pending"}}
    # )

    # logout
    # sign_in user

    # get "/my_applications"
    # assert_response :success
    # assert_select "p", "Status: Adoption Pending"
  end

  test "Staff can revert withdraw and remove by an adopter and the application reappears for adopter" do
    skip("while new ui is implemented")
    #   user = create(:adopter, :with_profile)
    #   application = create(:adopter_application, status: 0, adopter_foster_account: user.adopter_foster_account)
    #   sign_in user

    #   get "/my_applications"
    #   assert_response :success
    #   assert_select "form", 2

    #   # withdraw and remove in one request
    #   patch(
    #     "/my_application",
    #     params: {
    #       application: {
    #         id: application.id,
    #         status: "withdrawn",
    #         profile_show: false
    #       }
    #     }
    #   )

    #   assert_response :redirect
    #   follow_redirect!
    #   assert_select "form", 1
    #   logout

    #   sign_in create(:user, :verified_staff)
    #   patch(
    #     "/adopter_applications/#{application.id}",
    #     params: {
    #       adopter_application: {status: "adoption_pending", profile_show: "true"}
    #     }
    #   )

    #   logout
    #   sign_in user
    #   get "/my_applications"
    #   assert_response :success
    #   assert_select "form", 1
  end
end
