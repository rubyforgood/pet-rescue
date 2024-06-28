require "test_helper"

class FormSubmissionTest < ActiveSupport::TestCase
  context "associations" do
    should belong_to(:person)
    should belong_to(:organization)

    # should have_many(:adopter_applications)
    should have_many(:submitted_answers)
  end
end
