require "application_system_test_case"

class TasksTest < ApplicationSystemTestCase
  setup do
    @user = create(:user, :activated_staff)
    @organization = @user.organization
    set_organization(@organization)
    @pet = create(:pet)
    sign_in @user
  end

  test "creates a recurring task with a due date without redirecting" do
    due_date = (Date.today + 1.day)
    visit pet_path(@pet, active_tab: "tasks")

    click_link(href: new_pet_task_path(@pet))
    fill_in "Name", with: "Recurring Task"
    fill_in "Due date", with: due_date.strftime("%Y-%m-%d")
    check "recur"
    fill_in "Next due date in (days)", with: 5
    fill_in "Description", with: "Recurring task description"
    click_on "Create Task"

    assert_text "Recurring Task"
    assert_text "Due Date - #{due_date.strftime("%d %b")}"
    assert has_current_path?(pet_path(@pet, active_tab: "tasks"))
  end

  test "creates a recurring task without a due date without redirecting" do
    visit pet_path(@pet, active_tab: "tasks")

    click_link(href: new_pet_task_path(@pet))
    fill_in "Name", with: "Recurring Task"
    check "recur"
    fill_in "Description", with: "Recurring task description"
    click_on "Create Task"

    assert_text "Recurring Task"
    assert has_current_path?(pet_path(@pet, active_tab: "tasks"))
  end

  test "marking a recurring task as complete creates and displays a new task without redirecting" do
    recurring_task = create(:task, recurring: true, pet: @pet, name: "recurring task")

    visit pet_path(@pet, active_tab: "tasks")

    within("#edit_task_#{recurring_task.id}") do
      check "task_completed"
    end

    assert_text("recurring task", count: 2)
    assert has_current_path?(pet_path(@pet, active_tab: "tasks"))
  end
end
