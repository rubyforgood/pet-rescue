class AdopterProfilesController < ApplicationController
# prevent staff and admin from creating adopter_profile, but allow to view
  # authenticate before all actions


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
        format.html { redirect_to profile_path, notice: "Your profile was successfully created." }
        format.json { render :show, status: :created, location: @adopter_profile }
      else
        format.html { render :new, status: :unprocessable_entity, notice: 'Error. Try again.' }
        format.json { render json: @adopter_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @adopter_profile = current_user.adopter_account.adopter_profile
  end

  def edit
    @adopter_profile = current_user.adopter_account.adopter_profile
  end

  def update
    respond_to do |format|
      if @inventory.update(inventory_params)
        format.html { redirect_to inventory_url(@inventory), notice: "Inventory was successfully updated." }
        format.json { render :show, status: :ok, location: @inventory }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @inventory.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def adopter_profile_params
    params.require(:adopter_profile).permit(:adopter_account_id, :city, :country, :experience)
  end
end