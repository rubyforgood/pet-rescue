# frozen_string_literal: true

#
# Used as the base controller of all controllers that are scoped to an organization
# so that the tenant is properly set and everything is scoped to the organization to
# achieve multi-tenancy.
#

class Organizations::BaseController < ApplicationController
  before_action :debug_request
  set_current_tenant_through_filter
  before_action :set_tenant

  def set_tenant
    if Current.organization.blank?
      redirect_to root_path, alert: "Organization not found."
    else
      set_current_tenant(Current.organization)
    end
  end

  def debug_request
    logger.debug("TENANT: #{ActsAsTenant.current_tenant}")
  end
end
