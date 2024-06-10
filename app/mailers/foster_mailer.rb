class FosterMailer < ApplicationMailer
  def reminder(foster)
    @foster = foster

    @adopter_foster_account = foster.adopter_foster_account
    @user = @adopter_foster_account.user
    @pet = foster.pet

    mail to: @user.email, subject: "#{@pet.name}'s Reminder"
  end
end
