class MatchesController < ApplicationController
  before_action :active_staff, :same_organization?

  before_action :set_pet, only: %i[create]
  before_action :set_match, only: %i[destroy]

  def create
    @match = Match.new(match_params.merge(
      organization_id: @pet.organization_id
    ))

    if @match.save
      set_statuses_to_adoption_made
      redirect_back_or_to dashboard_index_path, notice: "Pet successfully adopted."
    else
      redirect_back_or_to dashboard_index_path, alert: "Error."
    end
  end

    @successful_application = @match.adopter_account
      .adopter_applications
      .where(pet_id: @match.pet_id)[0]
    AdopterApplication.set_status_to_withdrawn(@successful_application)

  def destroy
    if @match.destroy
      redirect_to pets_path, notice: "Adoption reverted & application set to 'Withdrawn'"
    else
      redirect_to pets_path, alert: "Failed to revert adoption"
    end
  end

  private

  def match_params
    params.permit(:pet_id, :adopter_account_id)
  end

  # set status on all applications for a pet
  def set_statuses_to_adoption_made
    @applications = Pet.find(params[:pet_id]).adopter_applications
    @applications.each do |app|
      unless app.status == "withdrawn"
        app.status = "adoption_made"
        app.save
      end
    end
  def set_pet
    @pet = Pet.find(match_params[:pet_id])
  end

  def set_match
    @match = Match.find(params[:id])
  end

  def get_pet_id
    return params[:pet_id] if params[:pet_id]

    Match.find(params[:id]).pet_id
  end

  # staff and pet in the same org?
  def same_organization?
    return if current_user.staff_account.organization_id == Pet.find(get_pet_id).organization.id

    redirect_to root_path, alert: "Unauthorized action."
  end
end
