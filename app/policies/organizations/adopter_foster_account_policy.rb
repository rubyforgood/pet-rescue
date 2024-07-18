class Organizations::AdopterFosterAccountPolicy < ApplicationPolicy
  pre_check :verify_organization!
  pre_check :verify_active_staff!

  alias_rule :deactivate?, :update_activation?, to: :activate?

  def index?
    permission?(:view_adopter_foster_accounts)
  end

  def activate?
    permission?(:manage_adopter_foster_accounts)
  end
end
