class SignUpMailer < ApplicationMailer

  default from: 'bajapetrescue@gmail.com'

  def adopter_welcome_email
    @user = params[:user]
    mail(to: @user.email, subject: 'Welcome to Baja Pet Rescue')
  end

  def staff_welcome_email
  
  end
end
