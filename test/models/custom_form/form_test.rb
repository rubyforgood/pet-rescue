require "test_helper"

module CustomForm
  class FormTest < ActiveSupport::TestCase
    context "associations" do
      should have_many(:form_profiles).dependent(:destroy)
      should have_many(:questions).dependent(:destroy)
    end

    context "validations" do
      should validate_presence_of(:name)
      should validate_presence_of(:title)
    end
  end
end