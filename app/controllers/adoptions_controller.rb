class AdoptionsController < ApplicationController

  before_action :verified_staff, :same_organization?

  def create
    @adoption = Adoption.new(adoption_params)

    if @adoption.save
      set_statuses_to_adoption_made
      redirect_to adopter_applications_path, notice: 'Dog successfully adopted.'
    else
      redirect_to adopter_applications_path, notice: 'Error. Adoption not saved.'

    end
  end

  private

  def adoption_params
    params.permit(:dog_id, :adopter_account_id)
  end

  # refactor this to search for adopter applications using Dog(dog_id)
  # this currently is at risk of updating the wrong records e.g., multiple simultaneous users
  def set_statuses_to_adoption_made
    @applications = Adoption.last.dog.adopter_applications
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

    redirect_to root_path, notice: 'Unauthorized action.'
  end
end
