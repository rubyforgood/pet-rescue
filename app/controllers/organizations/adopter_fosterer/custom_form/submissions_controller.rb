class Organizations::AdopterFosterer::CustomForm::SubmissionsController < Organizations::BaseController
  before_action :authenticate_user!
  before_action :set_application, only: %i[update]
  layout "adopter_foster_dashboard"

  def index
    authorize! CustomForm::Submission, with: CustomForm::SubmissionPolicy

    @applications = authorized_scope(CustomForm::Submission.where(profile_show: true), with: CustomForm::SubmissionPolicy)
  end

  def create
    @pet = Pet.find(application_params[:pet_id])
    authorize! CustomForm::Submission, context: {pet: @pet}, with: CustomForm::SubmissionPolicy

    @application = CustomForm::Submission.new(application_params)

    if @application.save
      redirect_to adoptable_pet_path(@application.pet),
        notice: t(".success", message: MessagesHelper.affirmations.sample)

      # mailer
      @org_staff = User.organization_staff(@pet.organization_id)
      StaffApplicationNotificationMailer.with(pet: @pet,
        organization_staff: @org_staff)
        .new_adoption_application.deliver_now
    else
      redirect_to adoptable_pet_path(@pet),
        alert: t(".error")
    end
  end

  # update :status to 'withdrawn' or :profile_show to false
  def update
    if @application.update(application_params)
      redirect_to adopter_fosterer_custom_form_submissions_path
    else
      redirect_to adopter_fosterer_profile_path, alert: t(".error")
    end
  end

  private

  def set_application
    @application = CustomForm::Submission.find(params[:id])
    authorize! @application, with: CustomForm::SubmissionPolicy
  end

  def application_params
    params.require(:submission).permit(
      :pet_id,
      :adopter_foster_account_id,
      :status,
      :profile_show
    )
  end
end
