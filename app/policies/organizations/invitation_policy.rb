class Organizations::InvitationPolicy < ApplicationPolicy
  pre_check :verify_organization!
  pre_check :verify_active_staff!

  def create?
    deny!
  end
end
