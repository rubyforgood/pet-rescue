require "test_helper"

class DevContactsMailerTest < ActionMailer::TestCase
  test "send message" do
    sender = create(:user)
    message = "this is a test message"

    assert_emails 1 do
      @dev_contact_email = DevContactsMailer.with(name: sender.first_name,
        email: sender.email,
        message: message)
        .send_message.deliver_now
    end

    assert_match(/#{sender.first_name}/, @dev_contact_email.body.encoded)
    assert_match(/#{sender.email}/, @dev_contact_email.body.encoded)
    assert_match(/#{message}/, @dev_contact_email.body.encoded)
  end
end
