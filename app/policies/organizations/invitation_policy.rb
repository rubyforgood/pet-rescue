class Organizations::InvitationPolicy < ApplicationPolicy
  pre_check :verify_organization!

  def create?
    permission?(:invite_staff)
  end
end
