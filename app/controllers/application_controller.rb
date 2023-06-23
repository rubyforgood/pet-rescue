class ApplicationController < ActionController::Base

  # authorization checks

  private

  def adopter_with_profile
    return if current_user.adopter_account && 
              current_user.adopter_account.adopter_profile

    redirect_to root_path, alert: 'Unauthorized action.'
  end

  def check_if_adopter
    return if current_user.adopter_account

    redirect_to root_path, alert: 'Profiles are for adopters only'
  end

  def verified_staff
    return if user_signed_in? &&
              current_user.staff_account &&
              current_user.staff_account.verified

    redirect_to root_path, alert: 'Unauthorized action.'
  end

  def dog_in_same_organization?(org_id)
    current_user.staff_account.organization_id == org_id
  end

end
