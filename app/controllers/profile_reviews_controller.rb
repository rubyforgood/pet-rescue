class ProfileReviewsController < ApplicationController
  # Controller to permit roles admin & staff to see user profiles
  # prevents role adopter from seeing other profiles

  before_action :verified_staff

  def show
    @adopter_profile = AdopterProfile.find(params[:id])
  end
end
