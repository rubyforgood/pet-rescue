class Organizations::AdoptionApplicationReviewsController < Organizations::BaseController
  before_action :active_staff
  layout "dashboard"

  def index
    @q = Pet.org_pets_with_apps(current_user.staff_account.organization_id).ransack(params[:q])
    @pets_with_applications = @q.result.includes(:adopter_applications)
    @pet = selected_pet

    # Combining these into a single chained statement does not yield the same result due to how Ransack processes parameters.
    if params[:q].present? && params[:q]["adopter_applications_status_eq"].present?
      status_filter = params[:q]["adopter_applications_status_eq"]
      @pets_with_applications = filter_by_application_status(@pets_with_applications, status_filter)
    end
  end

  def filter_by_application_status(pets_relation, status_filter)
    pets_relation.joins(:adopter_applications).where(adopter_applications: {status: status_filter})
  end

  def edit
    @application = AdopterApplication.find(params[:id])

    return if pet_in_same_organization?(@application.pet.organization_id)

    redirect_to dashboard_index_path,
      alert: 'Staff can only edit applications for their organization
                        pets.'
  end

  def update
    @application = AdopterApplication.find(params[:id])
    @applications_tab = request.referrer.include?("applications") # Change table display in pets/applications tab

    if pet_in_same_organization?(@application.pet.organization_id) &&
        @application.update(application_params)
      respond_to do |format|
        format.html { redirect_to dashboard_index_path }
        format.turbo_stream { flash.now[:notice] = "Application was successfully updated." }
      end
    else
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity }
        format.turbo_stream { flash.now[:alert] = "Error updating application" }
      end
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
