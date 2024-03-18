class ContactsController < ApplicationController
  skip_verify_authorized only: %i[new create]

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(name: params[:name],
      email: params[:email],
      message: params[:message])

    if @contact.valid?
      ContactsMailer.with(name: params[:name],
        email: params[:email],
        message: params[:message])
        .send_message(current_tenant.slug).deliver_now
      redirect_to root_path, notice: "Message sent!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def contacts_params
    params.require(:contact).permit(:name, :email, :message)
  end
end
