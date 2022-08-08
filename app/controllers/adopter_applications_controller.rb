# allows adopter users to create an adoption application and/or update status to 'withdrawn'
class AdopterApplicationsController < ApplicationController
  before_action :authenticate_user!
  before_action :adopter_with_profile

  # only create if an application does not exist
  # this is ugly. Refactor...
  def create
    if AdopterApplication.where(dog_id: params[:dog_id],
                                adopter_account_id: params[:adopter_account_id]).exists?
      redirect_to adoptable_dog_path(params[:dog_id]), notice: 'Application already exists.'
    else
      @application = AdopterApplication.new(application_params)
      if @application.save
        redirect_to profile_path, notice: 'Application submitted.'
      else
        render adoptable_dog_path(params[:dog_id]),
               status: :unprocessable_entity,
               notice: 'Error. Please try again.'
      end
    end
  end

  # update :status to 'withdrawn' or :profile_show to false
  def update
    @application = AdopterApplication.find(params[:id])

    if @application.update(application_params)
      redirect_to profile_path
    else
      redirect_to profile_path, notice: 'Error.'
    end
  end

  private

  # check these params are OK. Server output states missing param.
  def application_params
    params.permit(:id, :dog_id, :adopter_account_id, :status, :profile_show)
  end

  def adopter_with_profile
    return if current_user.adopter_account && 
              current_user.adopter_account.adopter_profile

    redirect_to root_path, notice: 'Unauthorized action.'
  end
end
