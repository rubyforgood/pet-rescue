class ContactsMailer < ApplicationMailer
  def send_message(tenant_org)
    @name = params[:name]
    @email = params[:email]
    @message = params[:message]
    @url = "https://www.bajapetrescue.com"
    multi_tenant_service = MultiTenantService.new(tenant_org)
    mail(from: multi_tenant_service.default_email,
         to: multi_tenant_service.contact_email,
         subject: "New Message via Website")
  end
end
