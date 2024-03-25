require "test_helper"
require "action_policy/test_helper"

class Organizations::FormsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @organization = ActsAsTenant.current_tenant
    @form = create(:form, organization: @organization)

    user = create(:staff)
    sign_in user
  end

  context "authorization" do
    include ActionPolicy::TestHelper

    context "new" do
      should "be authorized" do
        assert_authorized_to(
          :manage?, Form,
          context: { organization: @organization },
          with: Organizations::FormPolicy
        ) do
          get new_form_url
        end
      end
    end

    context "create" do
      setup do
        @params = {
          form: attributes_for(:form)
        }
      end

      should "be authorized" do
        assert_authorized_to(
          :manage?, Form,
          context: { organization: @organization },
          with: Organizations::FormPolicy
        ) do
          post forms_url, params: @params
        end
      end
    end
  end

  context "index" do
    should "be authorized" do
      assert_authorized_to(
        :manage?, Form,
        context: { organization: @organization },
        with: Organizations::FormPolicy
      ) do
        get forms_url
      end
    end

    should "have authorized scope" do
      assert_have_authorized_scope(
        type: :active_record_relation,
        with: Organizations::FormPolicy
      ) do
        get forms_url
      end
    end
  end

  context "show" do
    should "be authorized" do
      assert_authorized_to(
        :manage?, @form,
        with: Organizations::FormPolicy
      ) do
        get form_url(@form)
      end
    end
  end

  context "#edit" do
    should "be authorized" do
      assert_authorized_to(
        :manage?, @form,
        with: Organizations::FormPolicy
      ) do
        get edit_form_url(@form)
      end
    end
  end

  context "#update" do
    setup do
      @params = {
        form: {
          name: "new name"
        }
      }
    end

    should "be authorized" do
      assert_authorized_to(
        :manage?, @form,
        with: Organizations::FormPolicy
      ) do
        patch form_url(@form),
              params: @params
      end
    end
  end

  context "#destroy" do
    should "be authorized" do
      assert_authorized_to(
        :manage?, @form,
        with: Organizations::FormPolicy
      ) do
        delete form_url(@form)
      end
    end
  end

  test "should get index" do
    get forms_path

    assert_response :success
    assert_select "h2", text: "Forms"
  end

  test "should get new" do
    get new_form_path

    assert_response :success
    assert_select "h1", text: "New Form"
  end

  context "POST #create" do
    should "create new form" do
      assert_difference("@organization.forms.count", 1) do
        post forms_path, params: {
          form: attributes_for(:form)
        }
      end

      assert_response :redirect
      follow_redirect!
      assert_equal flash.notice, "Form saved successfully."
    end

    should "not create new form with missing params" do
      assert_difference("@organization.forms.count", 0) do
        post forms_path, params: {
          form: {
            name: "",
            title: ""
          }
        }
      end

      assert_template :new
    end
  end

  context "GET #show" do
    should "visit show page" do
      get form_path(@form)

      assert_response :success
      assert_select "h2", text: @form.name
    end

    should "not visit show page of non-existent form" do
      get form_path(id: Form.order(:id).last.id + 1)

      assert_response :redirect
      follow_redirect!
      assert_equal flash.alert, "Form not found."
    end

    should "not visit show page of form outside of organization" do
      o2 = create(:organization)
      f2 = create(:form, organization: o2)

      get form_path(id: f2.id)

      assert_response :redirect
      follow_redirect!
      assert_equal flash.alert, "Form not found."
    end
  end

  context "GET #edit" do
    should "visit edit page" do
      get edit_form_path(@form)

      assert_response :success
      assert_select "h1", text: "Edit Form"
    end

    should "not visit edit page of non-existent task" do
      get edit_form_path(id: Form.order(:id).last.id + 1)

      assert_response :redirect
      follow_redirect!
      assert_equal flash.alert, "Form not found."
    end

    should "not visit edit page of form outside of organization" do
      o2 = create(:organization)
      f2 = create(:form, organization: o2)

      get edit_form_path(id: f2.id)

      assert_response :redirect
      follow_redirect!
      assert_equal flash.alert, "Form not found."
    end
  end

  context "PATCH #update" do
    should "update form" do
      assert_changes "@form.name" do
        patch form_path(@form), params: {
          form: {
            name: Faker::Lorem.sentence
          }
        }

        @form.reload
      end

      assert_response :redirect
      follow_redirect!
      assert_equal flash.notice, "Form saved successfully."
    end

    should "not update form with missing param" do
      patch form_path(@form), params: {
        form: {
          name: ""
        }
      }

      assert_template :edit
    end

    should "not update form belonging to other org" do
      o2 = create(:organization)
      f2 = create(:form, organization: o2)

      assert_no_changes("f2.name") do
        patch form_path(id: f2.id), params: {
          form: {
            name: Faker::Lorem.sentence
          }
        }

        f2.reload
      end

      assert_response :redirect
      follow_redirect!
      assert_equal flash.alert, "Form not found."
    end
  end

  context "DELETE #destroy" do
    should "destroy a form" do
      assert_difference("@organization.forms.count", -1) do
        delete form_path(@form)
      end

      assert_response :redirect
      follow_redirect!
      assert_equal flash.notice, "Form was successfully deleted."
    end

    should "not delete form belonging to other org" do
      o2 = create(:organization)
      f2 = create(:form, organization: o2)

      assert_no_difference("@organization.forms.count") do
        delete form_path(id: f2.id)
      end

      assert_response :redirect
      follow_redirect!
      assert_equal flash.alert, "Form not found."
    end
  end
end
