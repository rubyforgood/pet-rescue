require "test_helper"

class Organizations::TaskServiceTest < ActiveSupport::TestCase
  test "creates new task with due date equal to previous task due date plus next due date in days if not overdue" do
    task = create(:task, recurring: true, due_date: 2.days.ago, next_due_date_in_days: 1)
    task.update(completed: true)

    assert_difference "Task.count", 1 do
      @new_task = Organizations::TaskService.new(task).create_next
    end

    assert @new_task.due_date.tomorrow
    assert_equal task.name, @new_task.name
    assert_equal task.description, @new_task.description
    assert_equal task.next_due_date_in_days, @new_task.next_due_date_in_days
    assert_equal task.pet_id, @new_task.pet_id
  end

  test "creates new task with due date equal to previous task completion date plus due date in days if overdue" do
    freeze_time

    current_time = Time.current

    task = create(:task, recurring: true, due_date: current_time + 2.days, next_due_date_in_days: 3)
    task.update(completed: true)

    assert_difference "Task.count", 1 do
      @new_task = Organizations::TaskService.new(task).create_next
    end

    assert_equal current_time + 5.days, @new_task.due_date
    assert_equal task.name, @new_task.name
    assert_equal task.description, @new_task.description
    assert_equal task.next_due_date_in_days, @new_task.next_due_date_in_days
    assert_equal task.pet_id, @new_task.pet_id
  end

  test "creates new task with due date nil if previous task had no due date" do
    task = create(:task, recurring: true, due_date: nil)
    task.update(completed: true)

    assert_difference "Task.count", 1 do
      @new_task = Organizations::TaskService.new(task).create_next
    end

    assert_nil @new_task.due_date
    assert_nil @new_task.next_due_date_in_days
    assert_equal task.name, @new_task.name
    assert_equal task.description, @new_task.description
    assert_equal task.pet_id, @new_task.pet_id
  end
end
