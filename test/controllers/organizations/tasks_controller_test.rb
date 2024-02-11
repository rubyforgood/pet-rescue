require "test_helper"
require "action_policy/test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    user = create(:user, :staff_admin)
    sign_in user

    @pet = create(:pet)
    @task = create(:task, pet: @pet)
  end

  context "authorization" do
    include ActionPolicy::TestHelper

    context "#new" do
      should "be authorized" do
        assert_authorized_to(
          :manage?, Task,
          context: {pet: @pet},
          with: TaskPolicy
        ) do
          get new_pet_task_url(@pet)
        end
      end
    end

    context "#create" do
      setup do
        @task = build(:task, pet: @pet)
        @params = {
          task: {
            name: @task.name,
            description: @task.description,
            completed: @task.completed
          }
        }
      end

      should "be authorized" do
        assert_authorized_to(
          :manage?, Task,
          context: {pet: @pet},
          with: TaskPolicy
        ) do
          post pet_tasks_url(@pet), params: @params
        end
      end
    end

    context "#edit" do
      should "be authorized" do
        assert_authorized_to(
          :manage?, @task,
          with: TaskPolicy
        ) do
          get edit_pet_task_url(@pet, @task)
        end
      end
    end

    context "#update" do
      setup do
        @params = {task: {name: "better name"}}
      end

      should "be authorized" do
        assert_authorized_to(
          :manage?, @task,
          with: TaskPolicy
        ) do
          patch pet_task_url(@pet, @task), params: @params
        end
      end
    end

    context "#destroy" do
      should "be authorized" do
        assert_authorized_to(
          :manage?, @task,
          with: TaskPolicy
        ) do
          delete pet_task_url(@pet, @task)
        end
      end
    end
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
