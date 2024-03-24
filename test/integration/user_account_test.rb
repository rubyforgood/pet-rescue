require "test_helper"

class UserAccountTest < ActionDispatch::IntegrationTest
  setup do
    @organization = create(:organization)
    host! "#{@organization.slug}.test.local"
  end

  test "user gets redirected to root page after sign in" do
    skip("while new ui is implemented")
  end

  test "Adopter user can sign up with an associated adopter account and sees success flash and welcome mail is sent" do
    skip("while new ui is implemented")
    # post(
    #   "/users",
    #   params: {
    #     user: {
    #       adopter_foster_account_attributes: {
    #         user_id: ""
    #       },
    #       email: "foo@bar.baz",
    #       first_name: "Foo",
    #       last_name: "Bar",
    #       password: "123456",
    #       tos_agreement: "1"
    #     },
    #     commit: "Create Account"
    #   }
    # )

    # mail = ActionMailer::Base.deliveries[0]
    # assert_equal "hello@test.test.localhost", mail.from.join, "from email is incorrect"
    # assert_equal "foo@bar.baz", mail.to.join, "to email is incorrect"
    # assert_equal "Welcome to Baja Pet Rescue", mail.subject, "subject is incorrect"
    # ActionMailer::Base.deliveries = []

    # assert_response :redirect
    # follow_redirect!

    # assert_equal "Welcome! You have signed up successfully.", flash[:notice]
    # assert(User.find_by(first_name: "Foo"))
    # assert_equal AdopterFosterAccount.last.user_id, User.last.id
  end

  test "error messages should appear if edit profile form is submitted without data" do
    skip("while new ui is implemented")
    # sign_in create(:adopter)

    # put(
    #   "/users",
    #   params: {
    #     user: {
    #       email: "",
    #       first_name: "",
    #       last_name: "",
    #       password: "",
    #       password_confirmation: "",
    #       current_password: "password"
    #     },
    #     commit: "Update"
    #   }
    # )

    # assert_response :success
    # assert_select "div.alert", count: 3
    # assert_select "div.alert", "Email can't be blank"
    # assert_select "div.alert", "First name can't be blank"
    # assert_select "div.alert", "Last name can't be blank"
  end

  test "user cannot update their profile with invalid password and should see error message" do
    skip("while new ui is implemented")
    # user = create(:adopter)
    # sign_in user

    # put(
    #   "/users",
    #   params: {
    #     user: {
    #       email: user.email,
    #       first_name: "Billy",
    #       last_name: "Noprofile",
    #       password: "",
    #       password_confirmation: "",
    #       current_password: "badpass"
    #     },
    #     commit: "Update"
    #   }
    # )

    # assert_response :success
    # assert_select "div.alert", count: 1
    # assert_select "div.alert", "Current password is invalid"

    # assert user.reload.valid_password?("password"), "Password updated without proper authorization"
  end

  test "user can update their password and see success flash" do
    skip("while new ui is implemented")
  end

  test "user can update their first name and see success flash" do
    skip("while new ui is implemented")
  end

  test "user can delete their account" do
    skip("while new ui is implemented")
  end

  test "error messages appear if sign up form is submitted without data" do
    skip("while new ui is implemented")
    # post(
    #   "/users",
    #   params: {
    #     user: {
    #       adopter_foster_account_attributes: {
    #         user_id: ""
    #       },
    #       email: "",
    #       first_name: "",
    #       last_name: "",
    #       password: "",
    #       password_confirmation: "",
    #       tos_agreement: "0"
    #     },
    #     commit: "Create Account"
    #   }
    # )

    # assert_select "div.alert", "Please accept the Terms and Conditions"
    # assert_select "div.alert", "Email can't be blank"
    # assert_select "div.alert", "Password can't be blank"
    # assert_select "div.alert", "First name can't be blank"
    # assert_select "div.alert", "Last name can't be blank"
    # assert_select "div.alert", "Tos agreement Please accept the Terms and Conditions"
  end

  test "email is sent when a user goes through Forgot Password flow" do
    skip("while new ui is implemented")
  end
end
