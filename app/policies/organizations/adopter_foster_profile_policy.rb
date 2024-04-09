class Organizations::AdopterFosterProfilePolicy < ApplicationPolicy
  def create?
    permission?(:create_adopter_foster_profiles) && no_profile?
  end

  def manage?
    owner? && permission?(:manage_adopter_foster_profiles)
  end

  private

  def no_profile?
    user&.adopter_foster_account&.adopter_foster_profile.nil?
  end

  def owner?
    user.id == record.adopter_foster_account.user_id
  end
end
