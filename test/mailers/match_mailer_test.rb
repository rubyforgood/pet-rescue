require "test_helper"

class MatchMailerTest < ActionMailer::TestCase
  test "checklist reminder" do
    email = MatchMailer.checklist_reminder(matches(:adoption_one))

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal [matches(:adoption_one).adopter_account.user.email], email.to
    assert_match(/Checklist Reminder/, email.subject)
    assert_match(/#{matches(:adoption_one).pet.name}/, email.subject)
    assert_match(/#{matches(:adoption_one).pet.name}/, email.body.encoded)
  end
end
