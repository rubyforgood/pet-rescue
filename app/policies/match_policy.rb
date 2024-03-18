class MatchPolicy < ApplicationPolicy
  pre_check :verify_organization!
  pre_check :verify_active_staff!

  def create?
    permission?(:manage_matches)
  end

  def destroy?
    permission?(:manage_matches)
  end
end
