require "test_helper"

class QuestionTest < ActiveSupport::TestCase
  context "associations" do
    should belong_to(:form)

    should have_one(:organization).through(:form)
  end

  context "validations" do
    should validate_presence_of(:name)
    should validate_presence_of(:label)
  end

  context ".ordered" do
    should "order questions in a form" do
      form = create(:form)
      q1 = create(:question, form:, sort_order: 1)
      q2 = create(:question, form:, sort_order: 0)

      assert_equal Question.ordered.all, [q2, q1]
    end
  end

  context "#snapshot" do
    should "return the correct snapshot" do
      q = create(:question)

      assert_equal q.snapshot, {label: q.label, options: q.options}
    end
  end
end
