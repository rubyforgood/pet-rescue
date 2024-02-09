class Organizations::InvitationPolicy < ApplicationPolicy
  pre_check :verify_organization!

  def new?
    create?
  end

  def create?
    permission?(:invite_staff)
  end
end
