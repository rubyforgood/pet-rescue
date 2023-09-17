# frozen_string_literal: true

class OrganizationMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    _, organization_path, _ = env["PATH_INFO"].split("/")

    status, headers, body = @app.call(env)
    [status, headers, body]
  end
end
