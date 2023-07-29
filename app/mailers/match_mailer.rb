class MatchMailer < ApplicationMailer
  def checklist_reminder(match)
    @match = match

    @adopter_account = match.adopter_account
    @user = @adopter_account.user
    @pet = match.pet

    mail to: @user.email, subject: "#{@pet.name}'s Checklist Reminder"
  end
end
