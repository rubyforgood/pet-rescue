class ProfileReviewPolicy < ApplicationPolicy
  pre_check :verify_organization!
  pre_check :verify_active_staff!

  def show?
    permission?(:view_adopter_profiles)
  end

  private

  def organization
    @organization || record.adopter_account.user.organization
  end
end
