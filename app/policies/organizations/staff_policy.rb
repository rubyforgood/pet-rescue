class Organizations::StaffPolicy < ApplicationPolicy
  pre_check :verify_organization!

  def index?
    permission?(:manage_staff)
  end

  def activate?
    permission?(:activate_staff) && record.user_id != user.id
  end

  def deactivate?
    activate?
  end

  def update_activation?
    activate?
  end
end
