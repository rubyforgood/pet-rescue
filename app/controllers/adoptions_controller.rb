class AdoptionsController < ApplicationController

  #before action - check it's verified staff; check it's for mutual organization

  def create
    @adoption = Adoption.new(adoption_params)

    if @adoption.save
      redirect_to adopter_applications_path, notice: 'Dog successfully adopted.'
    else
      redirect_to adopter_applications_path, notice: 'Error. Adoption not saved.'

    end
  end

  private
  
  def adoption_params
    params.permit(:adopter_profile_id, :dog_id)
  end


end