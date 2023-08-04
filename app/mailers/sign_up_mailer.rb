class SignUpMailer < ApplicationMailer
  def adopter_welcome_email
    @user = params[:user]
    @home_url = "https://www.bajapetrescue.com"
    @faq_url = "https://www.bajapetrescue.com/faq"
    mail(from: MultiTenantService.new(current_tenant.subdomain).default_email,
      to: @user.email,
      subject: "Welcome to Baja Pet Rescue")
  end

  def staff_welcome_email
    @user = params[:user]
    @home_url = "https://www.bajapetrescue.com"
    @faq_url = "https://www.bajapetrescue.com/faq"
    mail(from: MultiTenantService.new(current_tenant.subdomain).default_email,
      to: @user.email,
      subject: "Welcome to Baja Pet Rescue")
  end

  def admin_notification_new_staff
    @home_url = "https://www.bajapetrescue.com"
    @faq_url = "https://www.bajapetrescue.com/faq"
    @user = params[:user]
    mail(to: "wcrwater@gmail.com", subject: "New Staff Account")
  end
end
