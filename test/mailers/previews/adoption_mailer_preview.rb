# Preview all emails at http://localhost:3000/rails/mailers/adoption_mailer
class AdoptionMailerPreview < ActionMailer::Preview
  def reminder
    AdoptionMailer.reminder(Match.first)
  end
end
