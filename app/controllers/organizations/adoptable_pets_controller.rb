class Organizations::AdoptablePetsController < Organizations::BaseController
  skip_verify_authorized only: %i[index]
  before_action :set_liked_pets, only: %i[index show], if: -> { current_user&.adopter_foster_account }

  def index
    @pets = authorized_scope(
      Pet.includes(:adopter_applications, images_attachments: :blob),
      with: Organizations::AdoptablePetPolicy
    )
  end

  def show
    @adoptable_pet_info = PageText.first&.adoptable_pet_info
    @pet = Pet.find(params[:id])
    authorize! @pet, with: Organizations::AdoptablePetPolicy

    if current_user&.adopter_foster_account
      @adoption_application =
        AdopterApplication.find_by(
          pet_id: @pet.id,
          adopter_foster_account_id: current_user.adopter_foster_account.id
        ) ||
        @pet.adopter_applications.build(
          adopter_foster_account: current_user.adopter_foster_account
        )
    end
  end

  private

  def set_liked_pets
    @liked_pets = LikedPet.where(adopter_foster_account_id: current_user.adopter_foster_account.id)
  end
end
