module ApplicationHelper
  #
  # Returns the path to the home page of the organization.
  #
  #
  def organization_home_path(organization)
    home_index_path(script_name: "/#{organization.slug}")
  end
end
