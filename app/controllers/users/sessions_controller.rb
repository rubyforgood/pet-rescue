# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  include OrganizationScopable
  layout "application"
end
