class AdoptionApplicationReviewsController < ApplicationController

  before_action :verified_staff

  def index
    @dogs = Dog.org_dogs_with_apps(current_user.staff_account.organization_id)
    @dog = selected_dog
  end

  def edit
    @application = AdopterApplication.find(params[:id])

    return if dog_in_same_organization?(@application.dog.organization_id)

    redirect_to adopter_applications_path,
                alert: 'Staff can only edit applications for their organization 
                        dogs.'
  end

  def update
    @application = AdopterApplication.find(params[:id])

    if dog_in_same_organization?(@application.dog.organization_id) &&
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
  def selected_dog
    return if !params[:dog_id] || params[:dog_id] == ''

    Dog.where(id: params[:dog_id])
  end
end
