class ContactsController < ApplicationController

  def new
    @contact = Contact.new
  end

  def send_message
    redirect_to root_path, alert: 'this works'
  end

  private

  def contacts_params
    params.permit(:name, :email, :message)
  end
end