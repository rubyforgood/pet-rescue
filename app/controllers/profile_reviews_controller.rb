class ProfileReviewsController < ApplicationController
  # Controller to permit roles admin & staff to see user profiles
  # prevents role adopter from seeing other profiles

  before_action :active_staff

  def show
    @adopter_foster_profile = AdopterFosterProfile.find(params[:id])
  end
end
