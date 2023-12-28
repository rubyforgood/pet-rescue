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
end
