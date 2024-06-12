class Organizations::Staff::AdoptionSubmissionReviewsController < Organizations::BaseController
  before_action :set_adopter_submission, only: %i[edit update]

  include ::Pagy::Backend

  layout "dashboard"

  def index
    authorize! CustomForm::Submission,
      context: {organization: Current.organization},
      with: Organizations::SubmissionPolicy

    @q = authorized_scope(
      Pet.org_pets_with_apps(current_user.staff_account.organization_id)
    ).ransack(params[:q])
    @pets_with_submissions = @q.result.includes(:submissions)

    # Combining these into a single chained statement does not yield the same result due to how Ransack processes parameters.
    if params[:q].present? && params[:q]["submissions_status_eq"].present?
      status_filter = params[:q]["submissions_status_eq"]
      @pets_with_submissions = filter_by_submission_status(@pets_with_submissions, status_filter)
    end

    @pagy, @pets_with_submissions = pagy(@pets_with_submissions, items: 10)
  end

  def edit
  end

  def update
    @submissions_tab = request.referrer.include?("submissions") # Change table display in pets/submissions tab

    respond_to do |format|
      if @submission.update(submission_params)
        format.html { redirect_to staff_dashboard_index_path }
        format.turbo_stream { flash.now[:notice] = t(".success") }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.turbo_stream { flash.now[:alert] = t(".error") }
      end
    end
  end

  private

  def submission_params
    params.require(:custom_form_submission).permit(:status, :notes, :profile_show)
  end

  def set_adopter_submission
    @submission = CustomForm::Submission.find(params[:id])
    authorize! @submission, with: Organizations::SubmissionPolicy
  end

  def filter_by_submission_status(pets_relation, status_filter)
    pets_relation.joins(:submissions).where(submissions: {status: status_filter})
  end
end
