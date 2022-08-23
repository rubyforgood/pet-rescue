class SignUpMailer < ApplicationMailer

  default from: 'bajapetrescue@gmail.com'

  def adopter_welcome_email
    @user = params[:user]
    @url = 'http://localhost:3000/'
    mail(to: @user.email, subject: 'Welcome to Baja Pet Rescue')
  end

  def staff_welcome_email
    @user = params[:user]
    @url = 'http://localhost:3000/'
    mail(to: @user.email, subject: 'Welcome to Baja Pet Rescue')
  end

  def admin_notification_new_staff
    @url = 'http://localhost:3000/'
    @user = params[:user]
    mail(to: 'wcrwater+bajapetrescue@gmail.com', subject: 'New Staff Account')
  end
end
