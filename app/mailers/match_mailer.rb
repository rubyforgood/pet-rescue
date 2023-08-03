class MatchMailer < ApplicationMailer
  def checklist_reminder(match)
    @match = match

    @adopter_account = @match.adopter_account
    @user = @adopter_account.user
    @pet = @match.pet

    @assignments = @match.checklist_assignments.incomplete.order(:due_date)
    return if @assignments.required.none?

    mail to: @user.email, subject: "#{@pet.name}'s Checklist Reminder"
  end
end
