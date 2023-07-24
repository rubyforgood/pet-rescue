class AdoptionsController < ApplicationController

  before_action :verified_staff, :same_organization?

  def create
    @adoption = Adoption.new(adoption_params)

    if @adoption.save
      set_statuses_to_adoption_made
      redirect_to adopter_applications_path, notice: 'Pet successfully adopted.'
    else
      redirect_to adopter_applications_path, alert: 'Error.'

    end
  end

  def delete
    @adoption = Adoption.find(params[:adoption_id])

    @successful_application = @adoption.adopter_account
                                       .adopter_applications
                                       .where(pet_id: @adoption.pet_id)[0]
    AdopterApplication.set_status_to_withdrawn(@successful_application)

    if @adoption.destroy
      redirect_to pets_path, notice: "Adoption reverted & application set to 'Withdrawn'"
    else
      redirect_to pets_path, alert: 'Failed to revert adoption'
    end
  end

  private

  def adoption_params
    params.permit(:pet_id, :adopter_account_id, :adoption_id)
  end

  # set status on all applications for a pet
  def set_statuses_to_adoption_made
    @applications = Pet.find(params[:pet_id]).adopter_applications
    @applications.each do |app|
      unless app.status == 'withdrawn'
        app.status = 'adoption_made'
        app.save
      end
    end
  end

  def get_pet_id
    return params[:pet_id] if params[:pet_id]

    Adoption.find(params[:adoption_id]).pet_id
  end
  
  # staff and pet in the same org?
  def same_organization?
    return if current_user.staff_account.organization_id == Pet.find(get_pet_id).organization.id

    redirect_to root_path, alert: 'Unauthorized action.'
  end
end
