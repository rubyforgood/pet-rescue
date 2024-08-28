class DevContactsController < ApplicationController
  skip_before_action :authenticate_user!
  skip_verify_authorized only: %i[new create]

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)

    if @contact.valid?
      DevContactsMailer.with(contact_params).send_message.deliver_later
      redirect_to root_path, notice: I18n.t("contacts.create.success")
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :message)
  end
end
