class ContactsController < ApplicationController

  def new
    @contact = Contact.new
  end

  def create
    ContactsMailer.with(name: params[:name],
                        email: params[:email],
                        message: params[:message])
                  .send_message.deliver_now
  end

  private

  def contacts_params
    params.require(:contact).permit(:name, :email, :message)
  end
end