# # Per SimpleCov documentation, start gem before application
if ENV["COVERAGE"]
  require 'simplecov'
  SimpleCov.start do
    add_group "Model", "app/models"
    add_group "Controller", "app/controllers"
    add_group "Mailer", "app/mailers"
  end 
end

ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Devise test helpers
  include Devise::Test::IntegrationHelpers

  # Add more helper methods to be used by all tests here...
  def after_teardown
    super
    FileUtils.rm_rf(ActiveStorage::Blob.service.root)
  end
end
