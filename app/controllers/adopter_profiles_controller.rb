class AdopterProfilesController < ApplicationController
# prevent staff and admin from creating adopter_profile, but allow to view
  # authenticate before all actions


  def new
    @adopter_profile = AdopterProfile.new
  end

  def edit
    @adopter_profile = AdopterProfile.find(params[:id])
  end

  # make it so profile cannot be created if one already exists.
  # add unique true to user_profile_id in adopter_profile table
  # add Unique true to user_id in adopter_account table
  def create
    @adopter_profile = AdopterProfile.new(adopter_profile_params)

    respond_to do |format|
      if @adopter_profile.save
        format.html { redirect_to @adopter_profile, notice: "Your profile was successfully created." }
        format.json { render :show, status: :created, location: @adopter_profile }
      else
        format.html { render :new, status: :unprocessable_entity, notice: 'Error. Try again.' }
        format.json { render json: @adopter_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @adopter_profile = AdopterProfile.find(params[:id])
  end

  private

  def adopter_profile_params
    params.require(:adopter_profile).permit(:adopter_account_id, :city, :country, :experience)
  end
end