class Organizations::AdopterFosterAccountPolicy < ApplicationPolicy
  pre_check :verify_organization!
  pre_check :verify_active_staff!

  def index?
    permission?(:view_adopter_foster_accounts)
  end
end
