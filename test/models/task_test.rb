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

  test "does not allow recurring task with no due date to have next due date in days" do
    task = build(:task, recurring: true, due_date: nil, next_due_date_in_days: 5)

    assert_not task.valid?
  end

  test "does not allow non-recurring task to have due date in days" do
    task = build(:task, recurring: false, due_date: nil, next_due_date_in_days: 5)

    assert_not task.valid?
  end

  should validate_presence_of(:name)
  should validate_numericality_of(:next_due_date_in_days).only_integer.allow_nil
end
