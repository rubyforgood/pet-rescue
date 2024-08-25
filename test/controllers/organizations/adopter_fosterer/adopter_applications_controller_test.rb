require "test_helper"
require "action_policy/test_helper"

class Organizations::AdopterFosterer::AdopterApplicationsControllerTest < ActionDispatch::IntegrationTest
  context "authorization" do
    include ActionPolicy::TestHelper

    setup do
      @user = create(:adopter)
      sign_in @user
    end

    context "#index" do
      should "be authorized" do
        assert_authorized_to(
          :index?, AdopterApplication, with: AdopterApplicationPolicy
        ) do
          get adopter_fosterer_adopter_applications_url
        end
      end

      should "have authorized scope" do
        assert_have_authorized_scope(
          type: :active_record_relation, with: AdopterApplicationPolicy
        ) do
          get adopter_fosterer_adopter_applications_url
        end
      end

      should "count the total number of applications" do
        form_submission = create(:form_submission, person: @user.person)
        adopter_foster_account = create(:adopter_foster_account, user: @user)
        create_list(:adopter_application, 2, adopter_foster_account: adopter_foster_account, form_submission: form_submission)

        get adopter_fosterer_dashboard_index_path

        assert_equal 2, assigns(:application_count)
      end

      should "return zero when the total number of adopter applications is nil" do
        organization = ActsAsTenant.current_tenant
        _adopter_foster_account = build_stubbed(:adopter_foster_account, user: @user, organization: organization)

        get adopter_fosterer_dashboard_index_path
        assert_equal 0, assigns(:application_count)
      end
    end

    context "#create" do
      setup do
        @pet = create(:pet)
        @params = {adopter_application: {
          pet_id: @pet.id,
          adopter_foster_account_id: @user.adopter_foster_account.id
        }}
      end

      should "be authorized" do
        assert_authorized_to(
          :create?, AdopterApplication,
          context: {pet: @pet},
          with: AdopterApplicationPolicy
        ) do
          post adopter_fosterer_adopter_applications_url, params: @params
        end
      end
    end

    context "#update" do
      setup do
        @form_submission = create(:form_submission)
        @adopter_application = create(:adopter_application, user: @user, form_submission: @form_submission)
        @params = {adopter_application: {
          status: "withdrawn"
        }}
      end

      should "be authorized" do
        assert_authorized_to(
          :update?, @adopter_application, with: AdopterApplicationPolicy
        ) do
          patch adopter_fosterer_adopter_application_url(@adopter_application), params: @params
        end
      end
    end
  end
end
