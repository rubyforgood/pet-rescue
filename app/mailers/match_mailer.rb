class MatchMailer < ApplicationMailer
  def reminder(match)
    @match = match

    @adopter_account = match.adopter_account
    @user = @adopter_account.user
    @pet = match.pet

    mail to: @user.email, subject: "#{@pet.name}'s Reminder"
  end
end
