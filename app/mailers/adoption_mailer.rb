class AdoptionMailer < ApplicationMailer
  def reminder(match)
    person = match.person
    @pet = match.pet

    mail to: person.email, subject: "#{@pet.name}'s Reminder"
  end
end
