# Preview all emails at http://localhost:3000/rails/mailers/foster_mailer
class FosterMailerPreview < ActionMailer::Preview
  def reminder
    FosterMailer.reminder(Match.first)
  end
end
