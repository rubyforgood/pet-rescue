class ContactsMailer < ApplicationMailer
  def send_message
    @name = params[:name]
    @email = params[:email]
    @message = params[:message]
    @url = "https://www.bajapetrescue.com"
    mail(from: MultiTenantService.new(current_tenant.subdomain).default_email,
         to: "bajapetrescue+contact@gmail.com",
         subject: "New Message via Website")
  end
end
