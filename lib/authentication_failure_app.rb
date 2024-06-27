class AuthenticationFailureApp < Devise::FailureApp
  # This method is used to generate the URL for the redirect after a user fails to authenticate,
  # for example, when an unauthenticated user tries to access an authenticated route within an organization's scope.
  # The issue was that if a user failed to authenticate while in the context of an organization,
  # the organization's slug should be in the URL. So, after failing, the user would be redirected
  # to the sign-in page, but the organization's scope would be lost in the URL,
  # and it would fall back to the root URL instead of the organization's sign-in URL.
  # This fixes that to ensure the organization's slug is present in the URL.
  #
  # This code is 99% reproduced from the Devise gem's Devise::FailureApp class
  # at: lib/devise/failure_app.rb. The only exception is that we comment out the
  # 5th line:
  #   opts[:script_name] = nil
  #
  # This line was causing the`env["SCRIPT_NAME"]` value that's set by
  # OrganizationMiddleware to not be used when generating the route in the
  # statement `context.send(route, opts)`, which wipes out the current
  # Organization context on authentication failure.
  #
  # If Devise is upgraded, may need to compare this method across versions for
  # any needed updates.
  def scope_url
    opts = {}

    # Initialize script_name with nil to prevent infinite loops in
    # authenticated mounted engines in rails 4.2 and 5.0
    # opts[:script_name] = nil

    route = route(scope)

    opts[:format] = request_format unless skip_format?

    router_name = Devise.mappings[scope].router_name || Devise.available_router_name
    context = send(router_name)

    if relative_url_root?
      opts[:script_name] = relative_url_root

    # We need to add the rootpath to `script_name` manually for applications that use a Rails
    # version lower than 5.1. Otherwise, it is going to generate a wrong path for Engines
    # that use Devise. Remove it when the support of Rails 5.0 is dropped.
    elsif root_path_defined?(context) && !rails_51_and_up?
      rootpath = context.routes.url_helpers.root_path
      opts[:script_name] = rootpath.chomp("/") if rootpath.length > 1
    end

    if context.respond_to?(route)
      context.send(route, opts)
    elsif respond_to?(:root_url)
      root_url(opts)
    else
      "/"
    end
  end
end
