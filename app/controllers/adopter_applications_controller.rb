class AdopterApplicationsController < ApplicationController
  before_action :authenticate_user!
  before_action :adopter_with_profile
  
  def index

  end

  # def new

  # end

  # only create if an application does not exist
  def create
    if AdopterApplication.where(adopter_account_id: params[:adopter_account_id], 
                                dog_id: params[:dog_id]).exists?
      redirect_to adoptable_dog_path(params[:dog_id]), notice: 'You have already applied to adopt this dog.'
    else
      @application = AdopterApplication.new(application_params)
      if @application.save
        redirect_to profile_path, notice: 'You have applied to adopt this pooch!'
      else
        render :profile_path, status: :unprocessable_entity, notice: 'Error. Try again.'
      end
    end
  end

  # def edit

  # end

  # def update

  # end

  # def show

  # end

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
