class ApplicationController < ActionController::Base
  # verify_authorized unless: :devise_controller?

  before_action :set_current_user
  around_action :switch_locale

  def set_current_user
    Current.user = current_user
  end

  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end

  private

  def check_if_adopter
    return if current_user.adopter_account

    redirect_to root_path, alert: "Profiles are for adopters only"
  end

  def active_staff
    return if user_signed_in? &&
      current_user.staff_account &&
      !current_user.staff_account.deactivated?

    redirect_to root_path, alert: "Unauthorized action."
  end

  def pet_in_same_organization?(org_id)
    current_user.staff_account.organization_id == org_id
  end
end
