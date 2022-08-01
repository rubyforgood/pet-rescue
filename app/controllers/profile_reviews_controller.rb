class ProfileReviewsController < ApplicationController
  # Controller to permit roles admin & staff to see user profiles
  # prevents role adopter from seeing other profiles
  
  before_action :check_user_role
  
  def show
    @adopter_profile = AdopterProfile.find(params[:id])
  end

  private

  def check_user_role
    return unless user_signed_in? &&
    current_user.staff_account &&
    current_user.staff_account.verified

    redirect_to root_path, notice: 'Unauthorized action.'
  end
end
