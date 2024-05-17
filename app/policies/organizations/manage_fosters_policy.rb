class Organizations::ManageFostersPolicy < ApplicationPolicy
  pre_check :verify_organization!
  pre_check :verify_active_staff!

  def index?
    permission?(:manage_fosters)
  end
end
