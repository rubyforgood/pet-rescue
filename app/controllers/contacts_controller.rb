class ContactsController < ApplicationController

  def new
    @contact = Contact.new
  end

  def create
    redirect_to root_path, alert: 'this works'
    # make a mailer to handle this then handle outcomes
    # if sent, notice it was sent else alert there was an error
  end

  private

  def contacts_params
    params.permit(:name, :email, :message)
  end
end