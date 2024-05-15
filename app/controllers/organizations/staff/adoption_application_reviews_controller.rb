class Organizations::Staff::AdoptionApplicationReviewsController < Organizations::BaseController
  before_action :set_adopter_application, only: %i[edit update]

  include ::Pagy::Backend

  layout "dashboard"

  def index
    authorize! AdopterApplication,
      context: {organization: Current.organization}

    @q = authorized_scope(
      Pet.org_pets_with_apps(current_user.staff_account.organization_id)
    ).ransack(params[:q])
    @pets_with_applications = @q.result.includes(:adopter_applications)
    @pet = selected_pet

    # Combining these into a single chained statement does not yield the same result due to how Ransack processes parameters.
    if params[:q].present? && params[:q]["adopter_applications_status_eq"].present?
      status_filter = params[:q]["adopter_applications_status_eq"]
      @pets_with_applications = filter_by_application_status(@pets_with_applications, status_filter)
    end

    @pagy, @pets_with_applications = pagy(@pets_with_applications, items: 10)
  end

  def edit
  end

  def update
    @applications_tab = request.referrer.include?("applications") # Change table display in pets/applications tab

    respond_to do |format|
      if @application.update(application_params)
        format.html { redirect_to staff_dashboard_index_path }
        format.turbo_stream { flash.now[:notice] = "Application was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.turbo_stream { flash.now[:alert] = "Error updating application" }
      end
    end
  end

  private

  def application_params
    params.require(:adopter_application).permit(:status, :notes, :profile_show)
  end

  def set_adopter_application
    @application = AdopterApplication.find(params[:id])
    authorize! @application
  end

  # use where to return a relation for the view
  def selected_pet
    return if !params[:pet_id] || params[:pet_id] == ""

    Pet.where(id: params[:pet_id])
  end

  def filter_by_application_status(pets_relation, status_filter)
    pets_relation.joins(:adopter_applications).where(adopter_applications: {status: status_filter})
  end
end
