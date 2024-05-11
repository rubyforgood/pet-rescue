class Organizations::UserRolesPolicy < ApplicationPolicy
  pre_check :verify_organization!
  pre_check :verify_active_staff!
  alias_rule :to_staff?, :to_admin?, to: :change?

  def change?
    permission?(:change_user_roles) && record.id != user.id
  end
end
