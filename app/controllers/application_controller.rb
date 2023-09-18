class ApplicationController < ActionController::Base
  before_action :debug_request
  set_current_tenant_through_filter
  before_action :set_tenant
  around_action :switch_locale

  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end

  def debug_request
    logger.debug("SUBDOMAIN: #{request.subdomain}")
    logger.debug("TENANT: #{ActsAsTenant.current_tenant}")
  end

  def set_tenant
    org = Organization.find_by(subdomain: request.subdomain)
    set_current_tenant(org)
  end

  private

  def adopter_with_profile
    return if current_user.adopter_account&.adopter_profile

    redirect_to root_path, alert: "Unauthorized action."
  end

  def check_if_adopter
    return if current_user.adopter_account

    redirect_to root_path, alert: "Profiles are for adopters only"
  end

  def pet_in_same_organization?(org_id)
    current_user.organization_id == org_id
  end
end
