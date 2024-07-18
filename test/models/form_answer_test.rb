require "test_helper"

class FormAnswerTest < ActiveSupport::TestCase
  context "associations" do
    should belong_to(:person)
    should belong_to(:form_submission)
  end
end
