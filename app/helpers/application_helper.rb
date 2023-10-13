module ApplicationHelper
  #
  # Returns the path to the home page of the organization.
  #
  #
  def organization_home_path(organization)
    home_index_path(script_name: "/#{organization.slug}")
  end


  def path_to_partial(active_tab)
    "pets/#{active_tab}"
  end

end
