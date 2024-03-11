class AdoptablePetsController < Organizations::BaseController
  skip_verify_authorized only: %i[index]

  def index
    @pets = authorized_scope(
      Pet.includes(:adopter_applications, images_attachments: :blob),
      with: AdoptablePetPolicy
    )
  end

  def show
    @pet = Pet.find(params[:id])
    authorize! @pet, with: AdoptablePetPolicy

    if current_user
      @adoption_application =
        AdopterApplication.find_by(
          pet_id: @pet.id,
          adopter_account_id: current_user.adopter_account.id
        ) ||
        @pet.adopter_applications.build(
          adopter_account: current_user.adopter_account
        )
    end
  end
end
