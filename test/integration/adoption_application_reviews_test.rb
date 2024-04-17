require 'test_helper'

class AdoptionApplicationReviewsTest < ActionDispatch::IntegrationTest
  setup do
    @awaiting_review_app = create(:adopter_application, status: :awaiting_review)
    @under_review_app = create(:adopter_application, status: :under_review)
    @adoption_pending_app = create(:adopter_application, :adoption_pending)
    @withdrawn_app = create(:adopter_application, :withdrawn)
    @successful_applicant_app = create(:adopter_application, status: :successful_applicant)
    @adoption_made_app = create(:adopter_application, status: :adoption_made)
    @organization = create(:organization)
    @page_text = create(:page_text, organization: @organization)
    @organization.page_text = @page_text
    Current.organization = @organization
  end

  context 'non-staff' do
    should 'not see any applications' do
      get adoption_application_reviews_path

      assert_response :redirect
      follow_redirect!
      follow_redirect!
      assert_equal 'You are not authorized to perform this action.', flash[:alert]
    end
  end

  context 'active staff' do
    setup do
      sign_in create(:staff)
    end

    should 'see all applications' do
      get adoption_application_reviews_path

      assert_response :success
      AdopterApplication.all.each { |application| verify_application_elements application }
    end

    should 'be able to change the application status' do
      patch adoption_application_review_path(@awaiting_review_app.id),
            params: { adopter_application: { status: :under_review } },
            headers: { 'HTTP_REFERER' => 'example.com' }

      assert_response :redirect
      follow_redirect!
      @awaiting_review_app.reload
      assert_equal 'under_review', @awaiting_review_app.status
    end

    should 'be able to add a note to an application' do
      patch adoption_application_review_path(@under_review_app.id),
            params: { adopter_application: { notes: 'some notes' } },
            headers: { 'HTTP_REFERER' => 'example.com' }

      assert_response :redirect
      follow_redirect!

      @under_review_app.reload
      assert_equal('some notes', @under_review_app.notes)
    end

    context 'deactivated staff' do
      setup do
        sign_in create(:staff_account, :deactivated).user
      end

      should_eventually 'not see any applications' do
        get adoption_application_reviews_path

        assert_response :redirect
        follow_redirect!
        follow_redirect!
        assert_equal 'Unauthorized action.', flash[:alert]
      end
    end
  end

  def verify_application_elements(application)
    assert_select "tr[id='adopter_application_#{application.id}']" do
      adopter = application.adopter_foster_account.user
      assert_select 'a', text: "#{adopter.last_name}, #{adopter.first_name}"
      assert_select 'button', text: application.status.titleize
    end
  end
end
