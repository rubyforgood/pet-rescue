class ApplicationController < ActionController::Base
  verify_authorized unless: :devise_controller?

  before_action :set_current_user
  around_action :switch_locale

  def set_current_user
    Current.user = current_user
  end

  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end

  rescue_from ActionPolicy::Unauthorized do |ex|
    flash[:alert] = "You are not authorized to perform this action."

    redirect_back fallback_location: root_path
  end
end
