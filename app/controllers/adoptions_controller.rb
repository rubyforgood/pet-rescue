class AdoptionsController < ApplicationController

  #before action - check it's verified staff; check it's for mutual organization
  
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
    @adoption = Adoption.last
    @applications = @adoption.dog.adopter_applications
    @applications.each do |app|
      unless app.status == 'withdrawn'
        app.status = 'adoption_made'
        app.save
    end
  end
end
