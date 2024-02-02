require "test_helper"

class TaskTest < ActiveSupport::TestCase
  test "should have valid factory" do
    assert build(:task).valid?
  end

  test "should belong to a pet" do
    task = build(:task)
    assert_difference("task.pet.tasks.count", 1) do
      task.save
    end
  end

  test "completed defaults to false" do
    task = build(:task)
    refute task.completed
  end

  test "can set completed flag" do
    task = build(:task)
    refute task.completed

    task.completed = true
    assert task.completed
  end

  test "can update description" do
    task = create(:task, description: "Old description")

    assert_equal "Old description", task.description

    task.update(description: "New description")
    assert_equal "New description", task.description
  end

  should validate_presence_of(:name)
  should validate_numericality_of(:next_due_date_in_days).only_integer.allow_nil
end
