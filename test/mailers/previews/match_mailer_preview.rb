# Preview all emails at http://localhost:3000/rails/mailers/match_mailer
class MatchMailerPreview < ActionMailer::Preview
  def checklist_reminder
    MatchMailer.checklist_reminder(Adoption.first)
  end
end
