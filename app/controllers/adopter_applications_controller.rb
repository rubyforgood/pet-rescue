class AdopterApplicationsController < ApplicationController
  before_action :authenticate_user!
  before_action :adopter_with_profile
  
  def index

  end

  # def new

  # end

  # only create if an application does not exist
  def create
    @application = Application.new(application_params)
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
    params.require(:application).permit(:dog_id, :user_id)
  end

  def adopter_with_profile
    return if current_user.adopter_account && 
              current_user.adopter_account.adopter_profile

    redirect_to root_path, notice: 'Unauthorized action.'
  end

end
