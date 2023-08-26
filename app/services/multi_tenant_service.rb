class MultiTenantService
  def initialize(service_org_name)
    @service_org_name = service_org_name.to_sym
  end

  def default_email
    Rails.configuration.email_from[:default][service_org_name]
  end

  def contact_email
    Rails.configuration.email_from[:contact][service_org_name]
  end

  private

  attr_accessor :service_org_name
end
