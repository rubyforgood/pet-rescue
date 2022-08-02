class AdopterApplicationsController < ApplicationController
  before_action :authenticate_user!
  before_action :adopter_with_profile

  # only create if an application does not exist
  # this is ugly. Refactor...
  def create
    if AdopterApplication.where(adopter_account_id: params[:adopter_account_id],
                                dog_id: params[:dog_id]).exists?
      redirect_to adoptable_dog_path(params[:dog_id]),
                  notice: 'Application already exists.'
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

  def destroy

  end

  private

  def application_params
    params.permit(:dog_id, :adopter_account_id)
  end

  def adopter_with_profile
    return if current_user.adopter_account && 
              current_user.adopter_account.adopter_profile

    redirect_to root_path, notice: 'Unauthorized action.'
  end

end
