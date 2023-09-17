# frozen_string_literal: true

class OrganizationMiddleware
  def initialize(app)
    @app = app
  end

  #
  # This middleware properly allows setting the tenant via the path
  # See https://gorails.com/episodes/rails-active-support-current-attributes for more
  # information on how this works.
  #
  def call(env)
    _, organization_slug, request_path = env["REQUEST_PATH"].split("/")

    unless request_path.blank?
      # Used to set the tenant in the controller
      Current.organization = Organization.find_by(slug: organization_slug)

      if Current.organization.present?
        #
        # This is the magic that allows the tenant to be set via the path
        #
        env["SCRIPT_NAME"] = "/#{organization_slug}"
        env["PATH_INFO"] = "/#{request_path}"
        env["REQUEST_PATH"] = "/#{request_path}"
        env["REQUEST_URI"] = "/#{request_path}"
      end
    end

    status, headers, body = @app.call(env)
    [status, headers, body]
  end
end
