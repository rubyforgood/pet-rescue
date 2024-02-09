class Organizations::StaffPolicy < ApplicationPolicy
  pre_check :verify_organization!

  alias_rule :deactivate?, :update_activation?, to: :activate?

  def index?
    permission?(:manage_staff)
  end

  def activate?
    permission?(:activate_staff) && record.user_id != user.id
  end
end
