# Preview all emails at http://localhost:3000/rails/mailers/match_mailer
class MatchMailerPreview < ActionMailer::Preview
  def reminder
    MatchMailer.reminder(Match.first)
  end
end
