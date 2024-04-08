class Organizations::OrganizationProfilesController < Organizations::BaseController
  layout "dashboard"

  before_action :set_organization_profile, only: %i[edit update]

  def edit
  end

  def update
    if @organization_profile.update(organization_profile_params)
      redirect_to edit_organization_profile_path, notice: "Your profile has been updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def organization_profile_params
    params.require(:organization_profile).permit(
      :phone_number,
      :email,
      :avatar,
      :facebook_url,
      :instagram_url,
      :donation_url,
      location_attributes: %i[city_town country province_state]
    )
  end

  def set_organization_profile
    @organization_profile = OrganizationProfile.first

    authorize! @organization_profile
  end
end
