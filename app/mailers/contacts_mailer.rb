class ContactsMailer < ApplicationMailer

  def send_message
    @name = params[:name]
    @email = params[:email]
    @message = params[:message]
    @url = 'http://localhost:3000/'
    mail(to: 'wwcrwater@gmail.com', subject: 'New Message via Website')
  end
end
