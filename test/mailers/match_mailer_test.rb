require "test_helper"

class MatchMailerTest < ActionMailer::TestCase
  test "checklist reminder" do
    match = matches(:adoption_one)
    match.assign_checklist_template(checklist_templates(:one))

    email = MatchMailer.checklist_reminder(match)

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal [matches(:adoption_one).adopter_account.user.email], email.to
    assert_match(/Checklist Reminder/, email.subject)
    assert_match(/#{matches(:adoption_one).pet.name}/, email.subject)
    assert_match(/#{matches(:adoption_one).pet.name}/, email.body.encoded)
  end

  test "checklist reminder with no assignments" do
    match = matches(:adoption_one)

    email = MatchMailer.checklist_reminder(match)

    assert_emails 0 do
      email.deliver_now
    end
  end
end
