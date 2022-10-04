class ContactsMailer < ApplicationMailer

  default from: 'bajapetrescue@gmail.com'

  def send_message
    @name = params[:name]
    @email = params[:email]
    @message = params[:message]
    @url = 'http://localhost:3000/'
    mail(to: 'wcrwater@gmail.com', subject: 'New Message via Website')
  end
end
