class ErrorsController < ApplicationController
  verify_authorized
  skip_verify_authorized

  def not_found
    render status: 404
  end

  def internal_server_error
    render status: 500
  end

  def restricted_access
    render status: 422
  end
end
