class AdopterFosterProfilePolicy < ApplicationPolicy
  def create?
    permission?(:create_adopter_profiles) && no_profile?
  end

  def manage?
    owner? && permission?(:manage_adopter_profiles)
  end

  private

  def no_profile?
    user&.adopter_account&.adopter_foster_profile.nil?
  end

  def owner?
    user.id == record.adopter_account.user_id
  end
end
