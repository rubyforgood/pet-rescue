class Organizations::AdoptionApplicationReviewsController < Organizations::BaseController
  before_action :verified_staff
  layout "dashboard"

  def index
  #   @q = Pet.org_pets_with_apps(current_user.staff_account.organization_id).ransack(params[:q])
  #   @pets_with_applications = @q.result.includes(:adopter_applications)

    # @pets_with_applications = @q.result.includes(adopter_applications: [(:adopter_account => :user if params[:q]&.key?(:applicant_name_cont))])
    # include_user = params[:q]&.key?(:applicant_name_cont)
    # @pets_with_applications = if include_user
    #                             @q.result.includes(adopter_applications: { adopter_account: :user })
    #                           else
    #                             @q.result.includes(:adopter_applications)
    #                           end
    # @pets_with_applications = @q.result.includes(:adopter_applications)
    #                             .joins(adopter_applications: :user)


    # @q = AdopterApplication.joins(adopter_account: :user)
    #                        .where(pets: { id: organization_pets_scope })
    #                        .ransack(params[:q])

    organization_pets_scope = Pet.org_pets_with_apps(current_user.staff_account.organization_id)
    @q = Pet.where(id: organization_pets_scope)
            .joins(adopter_applications: { adopter_account: :user })
            .ransack(params[:q])
    @pets_with_applications= @q.result.includes(:adopter_applications, adopter_account: :user)
    # @pet = selected_pet

    @q_result = @q.result
    sql_query = @q_result.to_sql
    puts "YOOO Debug: params[:q] = #{params[:q]}"
    puts "wattt Debug: SQL query = #{@q}"
    puts 'HALLP', sql_query
    puts "PETZ #{@pets_with_applications}"
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
