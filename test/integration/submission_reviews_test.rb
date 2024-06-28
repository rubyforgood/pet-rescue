require "test_helper"

class SubmissionReviewsTest < ActionDispatch::IntegrationTest
  setup do
    @awaiting_review_sub = create(:submission, status: :awaiting_review)
    @under_review_sub = create(:submission, status: :under_review)
    @adoption_pending_sub = create(:submission, :adoption_pending)
    @withdrawn_sub = create(:submission, :withdrawn)
    @successful_applicant_sub = create(:submission, status: :successful_applicant)
    @adoption_made_sub = create(:submission, status: :adoption_made)
    @organization = create(:organization)
    @custom_page = create(:custom_page, organization: @organization)
    Current.organization = @organization
  end

  context "non-staff" do
    should "not see any submissions" do
      get staff_submission_reviews_path

      assert_response :redirect
      follow_redirect!
      follow_redirect!
      assert_equal I18n.t("errors.authorization_error"), flash[:alert]
    end
  end

  context "active staff" do
    setup do
      sign_in create(:staff)
    end

    should "see all submissions" do
      get staff_submission_reviews_path

      assert_response :success
      CustomForm::Submission.first(5).each { |submission| verify_submission_elements submission }
    end

    should "be able to change the submission status" do
      patch staff_submission_review_path(@awaiting_review_sub.id),
        params: {custom_form_submission: {status: :under_review}},
        headers: {"HTTP_REFERER" => "example.com"}

      assert_response :redirect
      follow_redirect!
      @awaiting_review_sub.reload
      assert_equal "under_review", @awaiting_review_sub.status
    end

    should "be able to add a note to an submission" do
      patch staff_submission_review_path(@under_review_sub.id),
        params: {custom_form_submission: {notes: "some notes"}},
        headers: {"HTTP_REFERER" => "example.com"}

      assert_response :redirect
      follow_redirect!

      @under_review_sub.reload
      assert_equal("some notes", @under_review_sub.notes)
    end

    context "deactivated staff" do
      setup do
        sign_in create(:staff_account, :deactivated).user
      end

      should_eventually "not see any submissions" do
        get staff_submission_reviews_path

        assert_response :redirect
        follow_redirect!
        follow_redirect!
        assert_equal "Unauthorized action.", flash[:alert]
      end
    end
  end

  def verify_submission_elements(submission)
    assert_select "div[id='table_custom_form_submission_#{submission.id}']" do
      adopter = submission.adopter_foster_account.user
      assert_select "a", text: "#{adopter.first_name} #{adopter.last_name}"
      assert_select "button", text: submission.status.titleize
    end
  end
end
