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

  def set_statuses_to_adoption_made
    @applications = Adoption.last.dog.adopter_applications
    @applications.each do |app|
      unless app.status == 'withdrawn'
        app.status = 'adoption_made'
        app.save
      end
    end
  end

  def verified_staff
    return if user_signed_in? &&
              current_user.staff_account &&
              current_user.staff_account.verified

    redirect_to root_path, notice: 'Unauthorized action.'
  end

  def same_organization?
    return if current_user.staff_account.organization_id ==
              Dog.find(params[:dog_id]).organization.id

    redirect_to root_path, notice: 'Unauthorized action.'
  end
end
