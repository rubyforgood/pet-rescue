class StaffApplicationNotificationMailer < ApplicationMailer
  def new_adoption_application
    @organization_staff = params[:organization_staff]
    @pet = params[:pet]

    emails = @organization_staff.collect(&:email).join(",")
    from_email = MultiTenantService.new(@pet.organization.slug).default_email
    mail(from: from_email,
      to: emails,
      subject: "New Adoption Application")
  end
end
