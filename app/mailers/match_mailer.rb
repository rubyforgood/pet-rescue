class MatchMailer < ApplicationMailer
  def reminder(match)
    @match = match

    @adopter_foster_account = match.adopter_foster_account
    @user = @adopter_foster_account.user
    @pet = match.pet

    mail to: @user.email, subject: "#{@pet.name}'s Reminder"
  end
end
