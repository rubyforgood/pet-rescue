module ApplicationHelper
  #
  # Returns the path to the home page of the organization.
  #
  #
  def organization_home_path(organization)
    home_index_path(script_name: "/#{organization.slug}")
  end

  def current_organization_name
    if Current.organization.present?
      Current.organization.name
    else
      Current.tenant.name
    end
  end
end
