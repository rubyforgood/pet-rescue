require "test_helper"
require "action_policy/test_helper"

class Organizations::Staff::Checklist::TaskTemplatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @organization = ActsAsTenant.current_tenant
    @task_template = create(:task_template)

    user = create(:staff)
    sign_in user
  end

  context "authorization" do
    include ActionPolicy::TestHelper

    context "new" do
      should "be authorized" do
        assert_authorized_to(
          :manage?, TaskTemplate,
          context: {organization: @organization},
          with: Organizations::TaskTemplatePolicy
        ) do
          get new_staff_checklist_task_template
        end
      end
    end

    context "create" do
      setup do
        @params = {
          task_template: attributes_for(:task_template)
        }
      end

      should "be authorized" do
        assert_authorized_to(
          :manage?, TaskTemplate,
          context: {organization: @organization},
          with: Organizations::TaskTemplatePolicy
        ) do
          post staff_checklist_task_templates_url, params: @params
        end
      end
    end

    context "index" do
      should "be authorized" do
        assert_authorized_to(
          :manage?, DefaultPetTask,
          context: {organization: @organization},
          with: Organizations::DefaultPetTaskPolicy
        ) do
          get staff_default_pet_tasks_url
        end
      end

      should "have authorized scope" do
        assert_have_authorized_scope(
          type: :active_record_relation,
          with: Organizations::DefaultPetTaskPolicy
        ) do
          get staff_default_pet_tasks_url
        end
      end
    end

    context "#edit" do
      should "be authorized" do
        assert_authorized_to(
          :manage?, @default_pet_task,
          with: Organizations::DefaultPetTaskPolicy
        ) do
          get edit_staff_default_pet_task_url(@default_pet_task)
        end
      end
    end

    context "#update" do
      setup do
        @params = {
          default_pet_task: {
            name: "new name"
          }
        }
      end

      should "be authorized" do
        assert_authorized_to(
          :manage?, @default_pet_task,
          with: Organizations::DefaultPetTaskPolicy
        ) do
          patch staff_default_pet_task_url(@default_pet_task),
            params: @params
        end
      end
    end

    context "#destroy" do
      should "be authorized" do
        assert_authorized_to(
          :manage?, @default_pet_task,
          with: Organizations::DefaultPetTaskPolicy
        ) do
          delete staff_default_pet_task_url(@default_pet_task)
        end
      end
    end
  end

  teardown do
    :after_teardown
  end

  test "should get index" do
    get staff_default_pet_tasks_path

    assert_response :success
    assert_select "h2", text: "Default Pet Tasks"
  end

  test "should get new" do
    get new_staff_default_pet_task_path

    assert_response :success
    assert_select "h1", text: "New Default Pet Task"
  end

  context "POST #create" do
    should "create new default pet task" do
      assert_difference("@organization.default_pet_tasks.count", 1) do
        post staff_default_pet_tasks_path, params: {
          default_pet_task: {
            name: "New Task",
            description: "Descrition of new Task",
            due_in_days: 5,
            recurring: true
          }
        }
      end

      assert_response :redirect
      follow_redirect!
      assert_equal "Default pet task saved successfully.", flash.notice
    end

    should "not create new default pet task with invalid or missing param" do
      assert_difference("@organization.default_pet_tasks.count", 0) do
        post staff_default_pet_tasks_path, params: {
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
      get edit_staff_default_pet_task_path(@default_pet_task)

      assert_response :success
      assert_select "h1", text: "Edit Default Pet Task"
    end

    should "not visit edit page of inexistent task" do
      get edit_staff_default_pet_task_path(id: DefaultPetTask.order(:id).last.id + 1)

      assert_response :redirect
      follow_redirect!
      assert_equal "Default Pet Task not found.", flash.alert
    end
  end

  context "PATCH #update" do
    should "update default pet task" do
      assert_changes "@default_pet_task.name" do
        patch staff_default_pet_task_path(@default_pet_task), params: {
          default_pet_task: {
            name: @default_pet_task.name + " new name"
          }
        }

        @default_pet_task.reload
      end

      assert_response :redirect
      follow_redirect!
      assert_equal "Default pet task updated successfully.", flash.notice
    end

    should "not update default pet task with invalid or missing param" do
      patch staff_default_pet_task_path(@default_pet_task), params: {
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
        delete staff_default_pet_task_path(@default_pet_task)
      end

      assert_response :redirect
      follow_redirect!
      assert_equal "Default pet task was successfully deleted.", flash.notice
    end

    should "not visit edit page of inexistent task" do
      delete staff_checklist_task_template_path(id: TaskTemplate.order(:id).last.id + 1)

      assert_response :redirect
      follow_redirect!
      assert_equal "Task Template not found.", flash.alert
    end
  end
end
