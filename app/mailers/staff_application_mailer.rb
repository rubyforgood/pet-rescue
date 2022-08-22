class StaffApplicationMailer < ActionMailer::Base
  default from: "from@example.com"
  layout "mailer"

  def new_adoption_application
    @staff = params[:staff]
    @adopter = params[:adopter]
    @dog = params[:dog]
    @url = 'http://example.com/login'
    mail(to: @staff.email, subject: 'New Adoption Application')
  end
end
