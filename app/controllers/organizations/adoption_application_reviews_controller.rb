class Organizations::AdoptionApplicationReviewsController < Organizations::BaseController
  before_action :verified_staff
  layout 'dashboard'

  def index
    @pets = Pet.org_pets_with_apps(current_user.staff_account.organization_id)
    @pet = selected_pet
  end

  def edit
    @application = AdopterApplication.find(params[:id])

    return if pet_in_same_organization?(@application.pet.organization_id)

    redirect_to adopter_applications_path,
      alert: 'Staff can only edit applications for their organization
                        pets.'
  end

  def update
    @application = AdopterApplication.find(params[:id])

    if pet_in_same_organization?(@application.pet.organization_id) &&
        @application.update(application_params)
      redirect_to adopter_applications_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def application_params
    params.require(:adopter_application).permit(:status, :notes, :profile_show)
  end

  # use where to return a relation for the view
  def selected_pet
    return if !params[:pet_id] || params[:pet_id] == ""

    Pet.where(id: params[:pet_id])
  end
end
