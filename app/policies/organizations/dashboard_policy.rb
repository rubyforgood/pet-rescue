class Organizations::DashboardPolicy < ApplicationPolicy
  pre_check :verify_organization!
  pre_check :verify_active_staff!

  def index?
    permission?(:view_organization_dashboard)
  end

  def incomplete_tasks?
    permission?(:view_organization_dashboard)
  end
end
