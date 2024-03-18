class AdopterApplicationsController < ApplicationController
  before_action :authenticate_user!

  def index
    authorize!

    @applications = authorized_scope(AdopterApplication.all)
  end

  def create
    @pet = Pet.find(application_params[:pet_id])
    authorize! context: {pet: @pet}

    @application = AdopterApplication.new(application_params)

    if @application.save
      redirect_to adoptable_pet_path(@application.pet),
        notice: "Application submitted! #{MessagesHelper.affirmations.sample}"

      # mailer
      @org_staff = User.organization_staff(@pet.organization_id)
      StaffApplicationNotificationMailer.with(pet: @pet,
        organization_staff: @org_staff)
        .new_adoption_application.deliver_now
    else
      redirect_to adoptable_pet_path(@pet),
        alert: "Error. Please try again."
    end
  end

  # update :status to 'withdrawn' or :profile_show to false
  def update
    @application = AdopterApplication.find(params[:id])
    authorize! @application

    if @application.update(application_params)
      redirect_to adopter_applications_path
    else
      redirect_to profile_path, alert: "Error."
    end
  end

  private

  def application_params
    params.require(:adopter_application).permit(
      :pet_id,
      :adopter_account_id,
      :status,
      :profile_show
    )
  end
end
