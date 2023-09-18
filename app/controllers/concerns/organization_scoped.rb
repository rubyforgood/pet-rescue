module OrganizationScoped 
  extend ActiveSupport::Concern
 
  included do
    set_current_tenant_through_filter
    before_action :set_tenant
  end

  def set_tenant
    if Current.organization.blank?
      redirect_to root_path, alert: "Organization not found."
    else
      set_current_tenant(Current.organization)
    end
  end

end
