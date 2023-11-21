require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    # @organization = create(:organization)
    @user = create(:user, :verified_staff, :staff_admin)
    @pet = create(:pet)
    @task = create(:task, pet: @pet)
    sign_in @user
    # binding.pry
  end

  test "should get new" do
    skip "Temporarily skipping this test for now"
    get new_pet_task_url(@pet)
    assert_response :success
  end

  test "new action should handle missing pet" do
    skip "Temporarily skipping this test for now"
    get new_pet_task_url(-1)
    assert_response :not_found
  end

  test "create action should handle invalid task parameters" do
    skip "Temporarily skipping this test for now"
    post pet_tasks_url(@pet), params: {task: {name: nil}}
    assert_response :success
  end

  test "edit action should handle non-existent task" do
    skip "Temporarily skipping this test for now"
    get edit_pet_task_url(@pet, -1)
    assert_response :not_found
  end

  test "update action should handle invalid update parameters" do
    skip "Temporarily skipping this test for now"
    patch pet_task_url(@pet, @task), params: {task: {name: nil}}
    assert_response :success
  end

  test "destroy action should handle non-existent task" do
    skip "Temporarily skipping this test for now"
    assert_no_difference "Task.count" do
      delete pet_task_url(@pet, -1)
    end
    assert_response :not_found
  end
end
