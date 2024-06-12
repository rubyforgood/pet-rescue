require "test_helper"
require "action_policy/test_helper"

class Organizations::AdopterFosterer::CustomForm::SubmissionsControllerTest < ActionDispatch::IntegrationTest
  context "authorization" do
    include ActionPolicy::TestHelper

    setup do
      @user = create(:adopter, :with_profile)
      sign_in @user
    end

    context "#index" do
      should "be authorized" do
        assert_authorized_to(
          :index?, CustomForm::Submission, with: CustomForm::SubmissionPolicy
        ) do
          get adopter_fosterer_custom_form_submissions_url
        end
      end

      should "have authorized scope" do
        assert_have_authorized_scope(
          type: :active_record_relation, with: CustomForm::SubmissionPolicy
        ) do
          get adopter_fosterer_custom_form_submissions_url
        end
      end

      should "count the total number of submissions" do
        organization = ActsAsTenant.current_tenant
        adopter_foster_account = create(:adopter_foster_account, user: @user, organization: organization)
        create_list(:submission, 2, adopter_foster_account: adopter_foster_account)

        get adopter_fosterer_dashboard_index_path

        assert_equal 2, assigns(:submission_count)
      end

      should "return zero when the total number of submissions is nil" do
        organization = ActsAsTenant.current_tenant
        _adopter_foster_account = build_stubbed(:adopter_foster_account, user: @user, organization: organization)

        get adopter_fosterer_dashboard_index_path
        assert_equal 0, assigns(:submission_count)
      end
    end

    context "#create" do
      setup do
        @pet = create(:pet)
        @params = {custom_form_submission: {
          pet_id: @pet.id,
          adopter_foster_account_id: @user.adopter_foster_account.id
        }}
      end

      should "be authorized" do
        assert_authorized_to(
          :create?, CustomForm::Submission,
          context: {pet: @pet},
          with: CustomForm::SubmissionPolicy
        ) do
          post adopter_fosterer_custom_form_submissions_url, params: @params
        end
      end
    end

    context "#update" do
      setup do
        @submission = create(:submission, user: @user)
        @params = {custom_form_submission: {
          status: "withdrawn"
        }}
      end

      should "be authorized" do
        assert_authorized_to(
          :update?, @submission, with: CustomForm::SubmissionPolicy
        ) do
          patch adopter_fosterer_custom_form_submission_url(@submission), params: @params
        end
      end
    end
  end
end
