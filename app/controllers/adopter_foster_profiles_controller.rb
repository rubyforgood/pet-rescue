class AdopterFosterProfilesController < ApplicationController
  verify_authorized

  before_action :authenticate_user!
  before_action :authorize!, only: %i[new create]
  before_action :set_profile, only: %i[show edit update]

  def new
    @adopter_foster_profile = AdopterFosterProfile.new
    @adopter_foster_profile.build_location
  end

  def create
    @adopter_foster_profile = AdopterFosterProfile.new(adopter_foster_profile_params)

    respond_to do |format|
      if @adopter_foster_profile.save
        format.html { redirect_to profile_path, notice: "Profile created" }
      else
        format.html { render :new, status: :unprocessable_entity, alert: "Error" }
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @adopter_foster_profile.update(adopter_foster_profile_params)
        format.html { redirect_to profile_path, notice: "Profile updated" }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_profile
    @adopter_foster_profile = current_user.adopter_account.adopter_foster_profile
    authorize! @adopter_foster_profile
  end

  def adopter_foster_profile_params
    params.require(:adopter_foster_profile).permit(:adopter_account_id,
      :phone_number,
      :contact_method,
      :ideal_pet,
      :lifestyle_fit,
      :activities,
      :alone_weekday,
      :alone_weekend,
      :experience,
      :contingency_plan,
      :shared_ownership,
      :shared_owner,
      :housing_type,
      :fenced_access,
      :fenced_alternative,
      :location_day,
      :location_night,
      :do_you_rent,
      :pets_allowed,
      :adults_in_home,
      :kids_in_home,
      :other_pets,
      :describe_pets,
      :checked_shelter,
      :surrendered_pet,
      :describe_surrender,
      :annual_cost,
      :visit_laventana,
      :visit_dates,
      :referral_source,
      location_attributes: [:city_town, :country, :province_state, :id])
  end
end
