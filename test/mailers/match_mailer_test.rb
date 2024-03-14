require "test_helper"

class MatchMailerTest < ActionMailer::TestCase
  test "reminder" do
    match = create(:match)
    email = MatchMailer.reminder(match)

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal [match.adopter_account.user.email], email.to
    assert_match(/#{match.pet.name}/, email.subject)
    assert_match(/#{match.pet.name}/, email.body.encoded)
  end
end
