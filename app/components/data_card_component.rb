# frozen_string_literal: true

class DataCardComponent < ViewComponent::Base
  def initialize
  end

  renders_one :title
  renders_one :icon_name
  renders_one :value

  private

  # Uses feather icons (app/assets/stylesheets/feather.css)
  def feather_classes
    "fe fe-#{icon_name}"
  end
end
