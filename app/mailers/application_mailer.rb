class ApplicationMailer < ActionMailer::Base
  default from: "from@example.com"
  layout "mailer"

  before_action :set_tenant_path

  private

  def set_tenant_path
    return unless Current.tenant

    default_url_options[:script_name] = "/#{Current.tenant.slug}"
  end
end
