module OrganizationScopable
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

  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.staff_account&.deactivated?
      adoptable_pets_path
    else
      pets_path
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    adoptable_pets_path
  end
end
