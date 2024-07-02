require "test_helper"

class CustomForm::SubmittedAnswerTest < ActiveSupport::TestCase
  context "associations" do
    should belong_to(:question)
    should belong_to(:user)
    should belong_to(:form_submission)

    should have_one(:form).through(:question)
    should have_one(:organization).through(:form)
  end
end
