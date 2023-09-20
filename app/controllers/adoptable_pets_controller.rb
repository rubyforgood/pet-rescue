class AdoptablePetsController < Organizations::BaseController
  def index
    @pets = Pet.includes(:adopter_applications, images_attachments: :blob).where.missing(:match)
  end

  def show
    @pet = Pet.find(params[:id])
    if AdopterApplication.adoption_exists?(current_user&.adopter_account&.id, @pet.id)
      @adoption_application = AdopterApplication.where(pet_id: @pet.id,
        adopter_account_id: current_user.adopter_account.id).first
    end

    return unless @pet.match

    redirect_to adoptable_pets_path, alert: "You can only view pets that need adoption."
  end
end
