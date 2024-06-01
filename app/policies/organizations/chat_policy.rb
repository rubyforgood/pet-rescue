class Organizations::ChatPolicy < ApplicationPolicy
  pre_check :verify_organization!
  pre_check :verify_active_staff!

  def index? = true

  def create? = true
end
