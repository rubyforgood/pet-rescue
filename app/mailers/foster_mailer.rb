class FosterMailer < ApplicationMailer
  def reminder(foster)
    person = foster.person
    @pet = foster.pet

    mail to: person.email, subject: "#{@pet.name}'s Reminder"
  end
end
