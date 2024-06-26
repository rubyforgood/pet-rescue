class Organizations::AdoptablePetsController < Organizations::BaseController
  include ::Pagy::Backend
  skip_verify_authorized only: %i[index]
  before_action :set_likes, only: %i[index show], if: -> { current_user&.adopter_foster_account }
  helper_method :get_animals

  def index
    @q = authorized_scope(Pet.includes(:adopter_applications, images_attachments: :blob),
      with: Organizations::AdoptablePetPolicy).ransack(params[:q])
    @pagy, paginated_adoptable_pets = pagy(
      @q.result,
      items: 9
    )
    @pets = paginated_adoptable_pets
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

  def get_animals
    Pet.species.keys.to_h do |s|
      [s, authorized_scope(Pet.where(species: s).distinct.order(:breed), with: Organizations::AdoptablePetPolicy).pluck(:breed)]
    end
  end

  def set_likes
    @likes = Like.where(adopter_foster_account_id: current_user.adopter_foster_account.id)
  end
end
