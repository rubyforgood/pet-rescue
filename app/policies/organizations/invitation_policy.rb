class Organizations::InvitationPolicy < ApplicationPolicy
  authorize :organization

  def new?
    create?
  end

  def create?
    permission?(:invite_staff) && organization.id == user.organization_id
  end
end
