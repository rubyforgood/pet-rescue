class Organizations::AdopterFosterer::LikedPetsController < Organizations::BaseController
  before_action :authenticate_user!
  before_action :set_pet, only: [:create]
  layout "adopter_foster_dashboard", only: :index

  def index
    authorize! with: Organizations::LikedPetPolicy

    @liked_pets = current_user.adopter_foster_account.liked_pets
  end

  def create
    @pet = Pet.find(application_params[:pet_id])
    authorize! context: {pet: @pet}, with: Organizations::LikedPetPolicy

    @liked_pet = LikedPet.new(adopter_foster_account_id: current_user.adopter_foster_account.id,
      pet_id: application_params[:pet_id])

    respond_to do |format|
      if @liked_pet.save
        format.html { redirect_to request.referrer, notice: "Pet added to your liked pets." }
        format.turbo_stream { flash.now[:notice] = "Pet added to your liked pets." }
      else
        format.html { redirect_to request.referrer, alert: "Error, pet was not added to your liked pets." }
        format.turbo_stream { flash.now[:alert] = "Error, pet was not added to your liked pets." }
      end
    end
  end

  def destroy
    @liked_pet = LikedPet.find(application_params[:id])
    authorize! context: {pet: @liked_pet.pet}, with: Organizations::LikedPetPolicy

    respond_to do |format|
      if @liked_pet.destroy
        format.html { redirect_to request.referrer, notice: "Pet removed from your liked pets." }
        format.turbo_stream { flash.now[:notice] = "Pet removed from your liked pets." }
      else
        format.html { redirect_to request.referrer, alert: "Error, pet was not removed from your liked pets." }
        format.turbo_stream { flash.now[:alert] = "Error, pet was not removed from your liked pets." }
      end
    end
  end

  private

  def application_params
    params.permit(:pet_id, :id, :_method, :authenticity_token)
  end

  def set_pet
    @pet = Pet.find(application_params[:pet_id])
  end
end
