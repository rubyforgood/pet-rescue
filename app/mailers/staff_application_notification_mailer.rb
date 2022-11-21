class StaffApplicationNotificationMailer < ApplicationMailer

  default from: 'bajapetrescue@gmail.com'

  def new_adoption_application
    @organization_staff = params[:organization_staff]
    @dog = params[:dog]
    @url = 'https://www.bajapetrescue.com/users/sign_in'

    emails = @organization_staff.collect(&:email).join(',')
    mail(to: emails, subject: 'New Adoption Application')
  end
end
