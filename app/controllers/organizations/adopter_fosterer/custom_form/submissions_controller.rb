module Organizations
  module AdopterFosterer
    module CustomForm
      class SubmissionsController < Organizations::BaseController
        before_action :authenticate_user!
        before_action :set_submission, only: %i[update]
        layout "adopter_foster_dashboard"

        def index
          authorize! ::CustomForm::Submission, with: ::CustomForm::SubmissionPolicy

          @submissions = authorized_scope(::CustomForm::Submission.where(profile_show: true), with: ::CustomForm::SubmissionPolicy)
        end

        def create
          @pet = Pet.find(submission_params[:pet_id])
          authorize! ::CustomForm::Submission, context: {pet: @pet}, with: ::CustomForm::SubmissionPolicy

          @submission = ::CustomForm::Submission.new(submission_params)

          if @submission.save
            redirect_to adoptable_pet_path(@submission.pet),
              notice: t(".success", message: MessagesHelper.affirmations.sample)

            # mailer
            @org_staff = User.organization_staff(@pet.organization_id)
            StaffSubmissionNotificationMailer.with(pet: @pet,
              organization_staff: @org_staff)
              .new_adoption_submission.deliver_now
          else
            redirect_to adoptable_pet_path(@pet),
              alert: t(".error")
          end
        end

        # update :status to 'withdrawn' or :profile_show to false
        def update
          if @submission.update(submission_params)
            redirect_to adopter_fosterer_custom_form_submissions_path
          else
            redirect_to adopter_fosterer_profile_path, alert: t(".error")
          end
        end

        private

        def set_submission
          @submission = ::CustomForm::Submission.find(params[:id])
          authorize! @submission, with: ::CustomForm::SubmissionPolicy
        end

        def submission_params
          params.require(:custom_form_submission).permit(
            :pet_id,
            :adopter_foster_account_id,
            :status,
            :profile_show
          )
        end
      end
    end
  end
end
