require "test_helper"

class Organizations::AdopterFosterer::FormSubmissionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @organization = ActsAsTenant.current_tenant
    @user = create(:adopter)
    sign_in @user
  end

  context 'create' do
    context 'when user has no form submission' do
      should 'create form submission' do
        assert_difference("FormSubmission.count") do
          post adopter_fosterer_form_submissions_url
        end
      end
    end

    context 'when user has a form submission' do
      setup do
        create(:form_submission, person_id: @user.person_id, organization_id: @organization.id)
      end

      should 'not create form submission' do
        assert_no_difference("FormSubmission.count") do
          post adopter_fosterer_form_submissions_url
        end
      end
    end
  end
end
