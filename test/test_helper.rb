# Per SimpleCov documentation, start gem before application
if ENV["COVERAGE"]
  require "simplecov"
  SimpleCov.start do
    add_group "Model", "app/models"
    add_group "Controller", "app/controllers"
    add_group "Mailer", "app/mailers"
  end
end

ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "minitest/unit"
require "mocha/minitest"

class ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Devise test helpers
  include Devise::Test::IntegrationHelpers

  def set_organization(organization)
    Rails.application.routes.default_url_options[:script_name] = if organization
      "/#{organization.slug}"
    else
      ""
    end
  end

  setup do
    ActsAsTenant.test_tenant = create(:organization, slug: "test")
    set_organization(ActsAsTenant.test_tenant)
  end

  def teardown
    ActsAsTenant.test_tenant = nil
    Rails.application.routes.default_url_options[:script_name] = ""
  end

  def check_messages
    assert_response :success
    assert_not response.parsed_body.include?("translation_missing"), "Missing translations, ensure this text is included in en.yml"
  end

  def after_teardown
    super
    FileUtils.rm_rf(ActiveStorage::Blob.service.root)
  end

  #
  # Sets up shoulda matcher configuration
  # https://github.com/thoughtbot/shoulda-matchers
  #
  Shoulda::Matchers.configure do |config|
    config.integrate do |with|
      with.test_framework :minitest
      with.library :rails
    end
  end
end

class ActionDispatch::IntegrationTest
  parallelize_setup do |i|
    ActiveStorage::Blob.service.root = "#{ActiveStorage::Blob.service.root}-#{i}"
  end
end
