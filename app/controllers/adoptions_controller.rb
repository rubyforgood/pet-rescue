class AdoptionsController < ApplicationController

  before_action :verified_staff, :same_organization?

  def create
    @adoption = Adoption.new(adoption_params)

    if @adoption.save
      set_statuses_to_adoption_made
      redirect_to adopter_applications_path, notice: 'Dog successfully adopted.'
    else
      redirect_to adopter_applications_path, alert: 'Error.'

    end
  end

  def delete
    @adoption = Adoption.find(params[:adoption_id])

    @successful_application = @adoption.adopter_account
                                       .adopter_applications
                                       .where(dog_id: @adoption.dog_id)[0]
    AdopterApplication.set_status_to_withdrawn(@successful_application)

    if @adoption.destroy
      redirect_to dogs_path, notice: "Adoption reverted & application set to 'Withdrawn'"
    else
      redirect_to dogs_path, alert: 'Failed to revert adoption'
    end
  end

  private

  def adoption_params
    params.permit(:dog_id, :adopter_account_id, :adoption_id)
  end

  # set status on all applications for a dog
  def set_statuses_to_adoption_made
    @applications = Dog.find(params[:dog_id]).adopter_applications
    @applications.each do |app|
      unless app.status == 'withdrawn'
        app.status = 'adoption_made'
        app.save
      end
    end
  end

  def get_dog_id
    return params[:dog_id] if params[:dog_id]

    Adoption.find(params[:adoption_id]).dog_id
  end
  
  # staff and dog in the same org?
  def same_organization?
    return if current_user.staff_account.organization_id == Dog.find(get_dog_id).organization.id

    redirect_to root_path, alert: 'Unauthorized action.'
  end
end
