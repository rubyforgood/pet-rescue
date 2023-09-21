require "test_helper"

class UserAccountTest < ActionDispatch::IntegrationTest
  setup do
    @organization = create(:organization)
    host! "#{@organization.subdomain}.test.local"
  end

  test "user gets redirected to root page after sign in" do
    user = create(:user, :adopter_with_profile)

    post(
      "/users/sign_in",
      params: {
        user: {email: user.email, password: "password"},
        commit: "Log in"
      }
    )

    assert_redirected_to root_path
    assert_equal "Signed in successfully.", flash[:notice]
  end

  test "user gets redirected to root page after sign out" do
    sign_in create(:user, :adopter_with_profile)

    delete destroy_user_session_path

    assert_redirected_to root_path
    assert_equal "Signed out successfully.", flash[:notice]
  end

  test "Adopter user can sign up with an associated adopter account and sees success flash and welcome mail is sent" do
    # post(
    #   "/users",
    #   params: {
    #     user: {
    #       adopter_account_attributes: {
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
    # assert_equal AdopterAccount.last.user_id, User.last.id
  end

  test "Staff user can sign up with an unverified staff account belonging to organization id 1 and see success flash" do
    # post(
    #   "/users",
    #   params: {
    #     user: {
    #       staff_account_attributes: {
    #         user_id: ""
    #       },
    #       email: "abc@123.com",
    #       first_name: "Ima",
    #       last_name: "Staff",
    #       password: "password",
    #       password_confirmation: "password",
    #       tos_agreement: "1"
    #     },
    #     commit: "Create Account"
    #   }
    # )

    # mail = ActionMailer::Base.deliveries
    # assert_equal "hello@test.test.localhost", mail[0].from.join, "from email is incorrect"
    # assert_equal "abc@123.com", mail[0].to.join, "to email is incorrect"
    # assert_equal "Welcome to Baja Pet Rescue", mail[0].subject, "subject is incorrect"

    # ActionMailer::Base.deliveries = []

    # assert_response :redirect
    # follow_redirect!

    # assert_equal "Welcome! You have signed up successfully.", flash[:notice]
    # assert(User.find_by(first_name: "Ima"))
    # assert(StaffAccount.find_by(organization_id: @organization.id))
  end

  test "error messages should appear if edit profile form is submitted without data" do
    # sign_in create(:user, :adopter_without_profile)

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
    # user = create(:user, :adopter_without_profile)
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
    user = create(:user, :adopter_without_profile)
    sign_in user

    put(
      "/users",
      params: {
        user: {
          email: user.email,
          first_name: "Billy",
          last_name: "Noprofile",
          password: "newpassword",
          password_confirmation: "newpassword",
          current_password: "password"
        },
        commit: "Update"
      }
    )

    assert_response :redirect
    assert_equal "Your account has been updated successfully.", flash[:notice]

    assert user.reload.valid_password?("newpassword"), "Updated password is not valid"
  end

  test "user can update their first name and see success flash" do
    user = create(:user, :adopter_without_profile)
    sign_in user

    put(
      "/users",
      params: {
        user: {
          email: user.email,
          first_name: "Etzio",
          last_name: "Auditore",
          password: "",
          password_confirmation: "",
          current_password: "password"
        },
        commit: "Update"
      }
    )

    assert_response :redirect
    assert_equal "Your account has been updated successfully.", flash[:notice]

    user.reload
    assert_equal "Etzio", user.first_name
    assert_equal "Auditore", user.last_name
  end

  test "user can delete their account" do
    user = create(:user, :adopter_without_profile)
    sign_in user

    assert(user)

    delete "/users"

    assert_nil(User.find_by(email: user.email))
  end

  test "error messages appear if sign up form is submitted without data" do
    # post(
    #   "/users",
    #   params: {
    #     user: {
    #       adopter_account_attributes: {
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
    user = create(:user)
    post(
      "/users/password",
      params: {
        user: {
          email: user.email
        },
        commit: "Send me reset password instructions"
      }
    )

    mail = ActionMailer::Base.deliveries[0]
    assert_equal mail.from.join, "please-change-me-at-config-initializers-devise@example.com", "from email is incorrect"
    assert_equal mail.to.join, user.email, "to email is incorrect"
    assert_equal mail.subject, "Reset password instructions", "subject is incorrect"
    ActionMailer::Base.deliveries = []
  end
end
