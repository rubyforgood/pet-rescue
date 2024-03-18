class Organizations::OrganizationProfilePolicy < ApplicationPolicy
  pre_check :verify_organization!
  pre_check :verify_active_staff!

  def manage?
    permission?(:manage_organization_profile)
  end
end
