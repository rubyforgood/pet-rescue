require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = create(:user, :activated_staff, :staff_admin)
    set_organization(@user.organization)
    @organization = ActsAsTenant.test_tenant
    @pet = create(:pet)
    @task = create(:task, pet: @pet)
    sign_in @user
  end

  test "should get new" do
    get new_pet_task_url(@pet)
    assert_response :success
  end

  test "new action should handle missing pet" do
    get new_pet_task_url(-1)
    assert_response :redirect
    assert_redirected_to pets_path
  end

  test "edit action should handle non-existent task" do
    get edit_pet_task_url(@pet, -1)
    assert_response :redirect
    assert_redirected_to pets_path
  end

  test "should allow creating task" do
    freeze_time

    current_time = Time.current 

    assert_difference "Task.count", 1 do
      post pet_tasks_url(@pet, format: :turbo_stream), params: {
        task: {
          name: "New Task",
          description: "New Task Description",
          due_date: current_time
        }
      }
    end

    created_task = Task.find_by(name: "New Task")
    assert_equal "New Task", created_task.name
    assert_equal "New Task Description", created_task.description
    assert_equal current_time, created_task.due_date

    assert_response :success
  end

  test "should handle creation failure" do
    freeze_time

    current_time = Time.current

    assert_no_difference "Task.count" do
      post pet_tasks_url(@pet, format: :turbo_stream), params: {
        task: {
          name: "",
          description: "New Task Description",
          due_date: current_time
        }
      }
    end

    assert_response :bad_request
  end

  test "should allow updating a task" do
    freeze_time

    current_time = Time.current

    patch pet_task_path(@pet, @task, format: :turbo_stream), params: {
      task: {
        name: "Updated Name",
        description: "Updated Description",
        due_date: current_time
      }
    }

    @task.reload

    assert_equal "Updated Name", @task.name
    assert_equal "Updated Description", @task.description
    assert_equal current_time, @task.due_date

    assert_response :success
  end

  test "should handle update failure" do
    freeze_time

    current_time = Time.current

    assert_no_changes "@task.name" do
      patch pet_task_path(@pet, @task, format: :turbo_stream), params: {
        task: {
          name: "",
          description: "Updated Description",
          due_date: current_time
        }
      }
    end

    assert_response :bad_request
  end

  test "should handle non-existent task during update" do
    non_existent_task_id = -1
    patch pet_task_path(@pet, non_existent_task_id), params: {task: {name: "Updated Name"}}

    assert_response :redirect
    assert_redirected_to pets_path
  end

  test "destroy action should handle non-existent task" do
    assert_no_difference "Task.count" do
      delete pet_task_url(@pet, -1)
    end
    assert_response :redirect
    assert_redirected_to pets_path
  end

  test "destroy action should remove task with Turbo Stream" do
    assert_difference "Task.count", -1 do
      delete pet_task_url(@pet, @task), as: :turbo_stream
    end

    assert_response :success
    assert_turbo_stream action: "remove", target: @task
  end
end
