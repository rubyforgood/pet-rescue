require "test_helper"

class FormTest < ActiveSupport::TestCase
  context "associations" do
    should belong_to(:organization)

    should have_many(:form_profiles).dependent(:destroy)
    should have_many(:questions).dependent(:destroy)
  end
end
