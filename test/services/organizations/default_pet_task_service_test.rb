require "test_helper"

class Organizations::DefaultPetTaskServiceTest < ActiveSupport::TestCase
  test "creates tasks from the organization's default tasks" do
    default_task = create(:default_pet_task)
    pet = create(:pet)

    Organizations::DefaultPetTaskService.new(pet).create_tasks

    assert_equal 1, pet.tasks.count
    assert_equal default_task.name, pet.tasks.first.name
    assert_nil pet.tasks.first.due_date
  end

  test "creates tasks with due_date set based on the default task's due_in_days" do
    create(:default_pet_task, due_in_days: 5)
    pet = create(:pet)

    Organizations::DefaultPetTaskService.new(pet).create_tasks

    assert_equal 5.days.from_now.beginning_of_day, pet.tasks.first.due_date
  end
end
