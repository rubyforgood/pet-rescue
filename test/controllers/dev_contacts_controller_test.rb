require "test_helper"

class DevContactsControllerTest < ActionDispatch::IntegrationTest
  context "new" do
    should "get new contacts" do
      get new_dev_contact_url
      assert_response :success
    end
  end

  context "create" do
    should "create contact mailer if valid params" do
      assert_emails 1 do
        post dev_contacts_url, params: {contact: {name: "test sender", email: "sender@test.com", message: "test message"}}
      end
    end

    should "return unprocessable entity if invalid params" do
      post dev_contacts_url, params: {contact: {name: "test sender", email: "sender@test.com"}}
      assert_response :unprocessable_entity
    end
  end
end
