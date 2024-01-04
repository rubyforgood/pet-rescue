class Organizations::OrganizationProfilesController < Organizations::BaseController
  layout "dashboard"

  def edit
    @organization_profile = Current.organization.profile
  end

  def update
    @organization_profile = Current.organization.profile
    if @organization_profile.update(organization_profile_params)
      redirect_to dashboard_index_path, notice: "Your profile has been updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def organization_profile_params
    params.require(:organization_profile).permit(
      :phone_number,
      :email,
      :about_us,
      :append_avatar,
      location_attributes: %i[city_town country province_state]
    )
  end
end
