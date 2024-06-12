require "test_helper"
require "action_policy/test_helper"

class Organizations::Staff::SubmissionReviewsControllerTest < ActionDispatch::IntegrationTest
  context "authorization" do
    include ActionPolicy::TestHelper

    setup do
      @organization = ActsAsTenant.current_tenant
      @submission = create(:submission)

      user = create(:staff)
      sign_in user
    end

    context "index" do
      should "be authorized" do
        assert_authorized_to(
          :manage?, CustomForm::Submission,
          context: {organization: @organization},
          with: Organizations::SubmissionPolicy
        ) do
          get staff_submission_reviews_url
        end
      end

      should "have authorized scope" do
        assert_have_authorized_scope(
          type: :active_record_relation,
          with: Organizations::PetPolicy
        ) do
          get staff_submission_reviews_url
        end
      end
    end

    context "#edit" do
      should "be authorized" do
        assert_authorized_to(
          :manage?, @submission,
          with: Organizations::SubmissionPolicy
        ) do
          get edit_staff_submission_review_url(@submission)
        end
      end
    end

    context "#update" do
      setup do
        loop do
          @new_status = CustomForm::Submission.statuses.keys.sample
          break if @new_status != @submission.status
        end

        @params = {
          custom_form_submission: {
            status: @new_status
          }
        }
      end

      should "be authorized" do
        assert_authorized_to(
          :manage?, @submission,
          with: Organizations::SubmissionPolicy
        ) do
          patch staff_submission_review_url(@submission),
            params: @params,
            headers: {"HTTP_REFERER" => "http://www.example.com/"}
        end
      end
    end
  end

  context "Filtering adoption submissions" do
    setup do
      @user = create(:staff)
      sign_in @user
    end

    teardown do
      :after_teardown
    end

    context "by pet name" do
      setup do
        @pet1 = create(:pet, name: "Pango")
        @pet2 = create(:pet, name: "Tycho")
        adopter_foster_account1 = create(:adopter_foster_account, :with_profile)
        adopter_foster_account2 = create(:adopter_foster_account, :with_profile)
        create(:submission, pet: @pet1, adopter_foster_account: adopter_foster_account1)
        create(:submission, pet: @pet2, adopter_foster_account: adopter_foster_account2)
      end

      should "return submissions for a specific pet name" do
        get staff_submission_reviews_url, params: {q: {name_i_cont: "Pango"}}
        assert_response :success
        assert_select "a.link-underline.link-underline-opacity-0", text: "Pango"
        refute_match "Tycho", @response.body
      end
    end

    context "by applicant name" do
      setup do
        @pet = create(:pet)
        adopter_foster_account1 = create(:adopter_foster_account, :with_profile,
          user: create(:user, first_name: "David", last_name: "Attenborough"))
        adopter_foster_account2 = create(:adopter_foster_account, :with_profile,
          user: create(:user, first_name: "Jane", last_name: "Goodall"))
        create(:submission, pet: @pet, adopter_foster_account: adopter_foster_account1)
        create(:submission, pet: @pet, adopter_foster_account: adopter_foster_account2)
      end

      should "return submissions for a specific applicant name" do
        get staff_submission_reviews_url, params: {q: {submissions_applicant_name_i_cont: "Attenborough"}}
        assert_response :success
        assert_select "a.link-underline.link-underline-opacity-0", text: "David Attenborough"
        refute_match "Goodall, Jane", @response.body
      end
    end

    context "Filtering by submission status" do
      setup do
        @pet = create(:pet)
        adopter_foster_account1 = create(:adopter_foster_account, :with_profile)
        adopter_foster_account2 = create(:adopter_foster_account, :with_profile)
        @submission_under_review = create(:submission, pet: @pet, adopter_foster_account: adopter_foster_account1, status: :under_review)
        @submission_awaiting_review = create(:submission, pet: @pet, adopter_foster_account: adopter_foster_account2, status: :awaiting_review)
      end

      should "return pets only with submissions of the specified status" do
        get staff_submission_reviews_url, params: {q: {submissions_status_eq: "under_review"}}
        assert_response :success
        assert_select "button.bg-dark-info", text: "Under Review"
        assert_select "button.bg-dark-primary", text: "Awaiting Review", count: 0
      end
    end
  end
end
