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

  private

  def adoption_params
    params.permit(:dog_id, :adopter_account_id)
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

  def same_organization?
    return if current_user.staff_account.organization_id ==
              Dog.find(params[:dog_id]).organization.id

    redirect_to root_path, alert: 'Unauthorized action.'
  end
end
