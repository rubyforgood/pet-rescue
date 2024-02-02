require "test_helper"

class Organizations::DefaultPetTasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user, :staff_admin)
    @default_pet_task = create(:default_pet_task)
    set_organization(@user.organization)
    @organization = @user.organization
    sign_in @user
  end

  teardown do
    :after_teardown
  end

  test "should get index" do
    get default_pet_tasks_path

    assert_response :success
    assert_select "h2", text: "Default Pet Tasks"
  end

  test "should get new" do
    get new_default_pet_task_path

    assert_response :success
    assert_select "h1", text: "New Default Pet Task"
  end

  context "POST #create" do
    should "create new default pet task" do
      assert_difference("@organization.default_pet_tasks.count", 1) do
        post default_pet_tasks_path, params: {
          default_pet_task: {
            name: "New Task",
            description: "Descrition of new Task",
            due_in_days: 5
          }
        }
      end

      assert_response :redirect
      follow_redirect!
      assert_equal flash.notice, "Default pet task saved successfully."
    end

    should "not create new default pet task with invalid or missing param" do
      assert_difference("@organization.default_pet_tasks.count", 0) do
        post default_pet_tasks_path, params: {
          default_pet_task: {
            name: "",
            description: "Descrition of new Task"
          }
        }
      end

      assert_template :new
    end
  end

  context "GET #edit" do
    should "visit edit page" do
      get edit_default_pet_task_path(@default_pet_task)

      assert_response :success
      assert_select "h1", text: "Edit Default Pet Task"
    end

    should "not visit edit page of inexistent task" do
      assert_raises(ActiveRecord::RecordNotFound) do
        get edit_default_pet_task_path(id: DefaultPetTask.order(:id).last.id + 1)
      end
    end
  end

  context "PATCH #update" do
    should "update default pet task" do
      assert_changes "@default_pet_task.name" do
        patch default_pet_task_path(@default_pet_task), params: {
          default_pet_task: {
            name: @default_pet_task.name + " new name"
          }
        }

        @default_pet_task.reload
      end

      assert_response :redirect
      follow_redirect!
      assert_equal flash.notice, "Default pet task updated successfully."
    end

    should "not update default pet task with invalid or missing param" do
      patch default_pet_task_path(@default_pet_task), params: {
        default_pet_task: {
          name: ""
        }
      }

      assert_template :edit
    end
  end

  context "DELETE #destroy" do
    should "destroy a default pet task" do
      assert_difference("@organization.default_pet_tasks.count", -1) do
        delete default_pet_task_path(@default_pet_task)
      end

      assert_response :redirect
      follow_redirect!
      assert_equal flash.notice, "Default pet task was successfully deleted."
    end

    should "not visit edit page of inexistent task" do
      delete default_pet_task_path(id: DefaultPetTask.order(:id).last.id + 1)

      assert_response :redirect
      follow_redirect!
      assert_equal flash.alert, "Failed to delete default pet task."
    end
  end
end
