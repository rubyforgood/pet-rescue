require "test_helper"

class MatchMailerTest < ActionMailer::TestCase
  test "checklist reminder" do
    match = create(:match)
    email = MatchMailer.checklist_reminder(match)

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal [match.adopter_account.user.email], email.to
    assert_match(/Checklist Reminder/, email.subject)
    assert_match(/#{match.pet.name}/, email.subject)
    assert_match(/#{match.pet.name}/, email.body.encoded)
  end
end
