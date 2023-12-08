class ApplicationMailer < ActionMailer::Base
  default from: "from@example.com"
  layout "mailer"

  around_action :with_organization_path, if: -> { Current.organization }

  private

  def with_organization_path
    default_url_options[:script_name] = "/#{Current.organization.slug}"
    yield
  ensure
    default_url_options[:script_name] = nil
  end
end
