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

  test "does not allow non-recurring task to have next due date in days" do
    task = build(:task, recurring: false, due_date: nil, next_due_date_in_days: 5)

    assert_not task.valid?
  end

  test "does not allow recurring task without due date to have next due date in days" do
    task = build(:task, recurring: true, due_date: nil, next_due_date_in_days: 5)

    assert_not task.valid?
  end

  should validate_presence_of(:name)

  test "should return tasks list in the correct order" do
    pet = build(:pet)
    task1 = create(:task, name: "task1", pet: pet, created_at: 1.day.ago, completed: true)
    task2 = create(:task, name: "task2", pet: pet, created_at: 2.days.ago, due_date: 1.day.from_now) # completed nil
    task3 = create(:task, name: "task3", pet: pet, created_at: 3.days.ago, completed: true, due_date: 1.day.from_now)
    task4 = create(:task, name: "task4", pet: pet, created_at: 4.days.ago, completed: false)
    task5 = create(:task, name: "task5", pet: pet, created_at: 5.days.ago, completed: false, updated_at: Time.current)
    task6 = create(:task, name: "task6", pet: pet, created_at: 6.days.ago, due_date: 2.day.from_now) # completed nil

    list = pet.tasks.list_ordered

    assert_equal([task2, task6, task5, task4, task3, task1], [list[0], list[1], list[2], list[3], list[4], list[5]])
  end
  should validate_numericality_of(:next_due_date_in_days).only_integer.allow_nil

  test "not_overdue scope should return tasks that are not overdue" do
    pet = build(:pet)
    overdue_task = create(:task, pet: pet, due_date: 1.day.ago)
    not_overdue_task_with_due_date = create(:task, pet: pet, due_date: 1.day.from_now)
    not_overdue_task_without_due_date = create(:task, pet: pet, due_date: nil)

    not_overdue_tasks = Task.not_overdue

    assert_includes not_overdue_tasks, not_overdue_task_with_due_date
    assert_includes not_overdue_tasks, not_overdue_task_without_due_date
    refute_includes not_overdue_tasks, overdue_task
  end

  test "overdue scope should return tasks that are overdue" do
    pet = build(:pet)
    overdue_task = create(:task, pet: pet, due_date: 1.day.ago)
    not_overdue_task_with_due_date = create(:task, pet: pet, due_date: 1.day.from_now)
    not_overdue_task_without_due_date = create(:task, pet: pet, due_date: nil)

    overdue_tasks = Task.overdue

    assert_includes overdue_tasks, overdue_task
    refute_includes overdue_tasks, not_overdue_task_with_due_date
    refute_includes overdue_tasks, not_overdue_task_without_due_date
  end
end
