require "test_helper"

class ContactFormTest < ActionDispatch::IntegrationTest
  test "All errors and custom messages appear on blank form submission" do
    skip("while new ui is implemented")
    # user = create(:user, :adopter_without_profile)
    # sign_in user

    # get(
    #   "/contacts",
    #   params: {
    #     name: "",
    #     email: "",
    #     message: "",
    #     commit: "Submit"
    #   }
    # )

    # assert_select "div.alert", "Please fix 3 errors highlighted below.", 1
    # assert_select "div.alert", "Name can't be blank", 1
    # assert_select "div.alert", "Email can't be blank", 1
    # assert_select "div.alert", "Message can't be blank", 1
  end

  test "should successfully submit form" do
    skip("while new ui is implemented")
    # user = create(:user, :adopter_without_profile)
    # sign_in user

    # assert_emails 1 do
    #   get(
    #     "/contacts",
    #     params: {
    #       name: "Samuel",
    #       email: "samuel@jackson.com",
    #       message: "Example help message.",
    #       commit: "Submit"
    #     }
    #   )
    # end

    # assert_response :redirect
    # follow_redirect!
    # assert_response :success

    # assert_equal flash[:notice], "Message sent!"
  end
end
