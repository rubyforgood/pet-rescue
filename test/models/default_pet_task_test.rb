require "test_helper"

class DefaultPetTaskTest < ActiveSupport::TestCase
  should validate_presence_of(:name)
  should validate_presence_of(:description)

  test "should have valid factory" do
    assert build(:default_pet_task).valid?
  end

  test "should belong to an organization" do
    default_pet_task = build(:default_pet_task)
    assert_difference("default_pet_task.organization.default_pet_tasks.count", 1) do
      default_pet_task.save
    end
  end

  test "can update description" do
    default_pet_task = create(:default_pet_task, description: "Old description")

    assert_equal "Old description", default_pet_task.description

    default_pet_task.update(description: "New description")
    assert_equal "New description", default_pet_task.description
  end

  test "can update name" do
    default_pet_task = create(:default_pet_task, description: "Old Name")

    assert_equal "Old Name", default_pet_task.description

    default_pet_task.update(description: "New Name")
    assert_equal "New Name", default_pet_task.description
  end
end
