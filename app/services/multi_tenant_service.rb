class MultiTenantService

  def initialize(service_org)
    @service_org = service_org.to_sym
  end

  def default_email
    Rails.configuration.email_from[:default][service_org]
  end

  def contact_email
    Rails.configuration.email_from[:contact][service_org]
  end
  
  private

  attr_accessor :service_org
end
