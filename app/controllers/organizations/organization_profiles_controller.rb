class Organizations::OrganizationProfilesController < ApplicationController
  before_action :verified_staff

  def edit
    @organization_profile = Current.organization.profile
  end

  def update
    @organization_profile = Current.organization.profile
    
    respond_to do |format|
      if @organization_profile.update(organization_profile_params)
        format.html { redirect_to dashboard_index_path, notice: "Profile updated" }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  private

  def organization_profile_params
    params.require(:organization_profile).permit(
      :phone_number,
      :email,
      location_attributes: %i[city_town country province_state id])
  end
end
