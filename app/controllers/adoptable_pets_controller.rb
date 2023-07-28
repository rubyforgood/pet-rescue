class AdoptablePetsController < ApplicationController

  # outer left join on Pet and Adoption
  def index
    @pets = Pet.includes(:adopter_applications, images_attachments: :blob).where.missing(:adoption)
  end

  def show
    @pet = Pet.find(params[:id])

    return unless @pet.adoption

    redirect_to adoptable_pets_path, alert: 'You can only view pets that need adoption.'
  end
end
