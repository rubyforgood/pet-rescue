class ContactsMailer < ApplicationMailer

  default from: 'bajapetrescue@gmail.com'

  def send_message
    @name = params[:name]
    @email = params[:email]
    @message = params[:message]
    @url = 'https://www.bajapetrescue.com'
    mail(to: 'bajapetrescue@gmail.com', subject: 'New Message via Website')
  end
end
