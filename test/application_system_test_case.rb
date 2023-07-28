require "test_helper"
require "capybara/cuprite"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  Capybara.javascript_driver = :cuprite
  Capybara.register_driver(:cuprite) do |app|
    Capybara::Cuprite::Driver.new(app, window_size: [1200, 1200])
  end

  driven_by :cuprite, using: :chrome
end
