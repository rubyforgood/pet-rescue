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
    if allowed_to?(
      :index?, Pet, namespace: Organizations,
      context: {organization: Current.organization}
    )
      pets_path
    else
      adoptable_pets_path
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    adoptable_pets_path
  end

  def verify_organization_for_current_user
    if current_user.blank? || current_user.organization.id != ActsAsTenant.current_tenant.id
      redirect_to root_path, alert: "Wrong organization."
    end
  end
end
