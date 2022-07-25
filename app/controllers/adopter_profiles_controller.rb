class AdopterProfilesController < ApplicationController
  before_action :authenticate_user!
  # prevent staff and admin from creating adopter_profile, but allow to view


  def new
    @adopter_profile = AdopterProfile.new
  end

  # make it so profile cannot be created if one already exists.
  # add unique true to user_profile_id in adopter_profile table
  # add Unique true to user_id in adopter_account table
  def create
    @adopter_profile = AdopterProfile.new(adopter_profile_params)

    respond_to do |format|
      if @adopter_profile.save
        format.html { redirect_to profile_path, notice: 'Your profile was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity, notice: 'Error. Try again.' }
      end
    end
  end

  def show
    @adopter_profile = adopter_profile
  end

  def edit
    @adopter_profile = adopter_profile
  end

  def update
    @adopter_profile = current_user.adopter_account.adopter_profile
    respond_to do |format|
      if @adopter_profile.update(adopter_profile_params)
        format.html { redirect_to profile_path, notice: "Your profile was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  private

  def adopter_profile
    current_user.adopter_account.adopter_profile
  end

  def adopter_profile_params
    params.require(:adopter_profile).permit(:adopter_account_id, :city, :country, :experience)
  end
end