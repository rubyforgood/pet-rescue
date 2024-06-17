# frozen_string_literal: true

class DashboardPageComponent < ViewComponent::Base
  attr_reader :crumb, :crumb_options

  def initialize(crumb: nil, crumb_options: [])
    @crumb = crumb
    @crumb_options = crumb_options
  end

  renders_one :header_title
  renders_one :header_subtitle
  renders_one :action
  renders_one :nav_tabs
  renders_one :body

  def before_render
    breadcrumb crumb, *crumb_options if crumb
    # unless header_title.present?
    #   raise ArgumentError, "Header title is required"
    # end
  end
end
