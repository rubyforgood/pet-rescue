class AdoptionApplicationReviewsController < ApplicationController

  before_action :verified_staff

  def index
    @dogs = all_org_dogs_with_apps
    @dog = selected_dog
  end

  def edit
    @application = AdopterApplication.find(params[:id])

    return if dog_in_same_organization?(@application)

    redirect_to adopter_applications_path,
                notice: 'Staff can only edit/update applications for their organization dogs.'
  end

  def update
    @application = AdopterApplication.find(params[:id])

    if dog_in_same_organization?(@application) && @application.update(application_params)
      redirect_to adopter_applications_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def application_params
    params.require(:adopter_application).permit(:status, :notes)
  end

  def selected_dog
    return if !params[:dog_id] || params[:dog_id] == ''

    Dog.find(params[:dog_id])
  end

  # dogs with same organization_id as current staff && have applications && have no adoption
  def all_org_dogs_with_apps
    Dog.where(organization_id: current_user.staff_account.organization_id)
       .includes(:adopter_applications).where.not(adopter_applications: { id: nil })
       .includes(:adoption).where(adoption: { id: nil })
  end

  def dog_in_same_organization?(application)
    current_user.staff_account.organization_id == application.dog.organization_id
  end

  def verified_staff
    return if user_signed_in? &&
              current_user.staff_account &&
              current_user.staff_account.verified

    redirect_to root_path, notice: 'Unauthorized action.'
  end

end
