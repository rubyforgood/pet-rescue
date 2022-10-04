class ContactsMailer < ApplicationMailer

  default from: 'bajapetrescue@gmail.com'

  def send_message
    @name = params[:name]
    @email = params[:email]
    @message = params[:message]
    @url = 'http://localhost:3000/'
    mail(to: ENV['EMAIL_ADDRESS'], subject: 'New Message via Website')
  end
end
