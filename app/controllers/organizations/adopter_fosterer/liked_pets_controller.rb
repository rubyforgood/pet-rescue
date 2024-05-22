class Organizations::AdopterFosterer::LikedPetsController < Organizations::BaseController
  before_action :authenticate_user!
  before_action :set_pet, only: [:create]

  def index
    # Use this to show liked pets in dashboard
  end

  def create
    @pet = Pet.find(application_params[:pet_id])
    authorize! context: {pet: @pet}, with: LikedPetPolicy

    @liked_pet = LikedPet.new(user_id: current_user.id, pet_id: application_params[:pet_id])

    respond_to do |format|
      if @liked_pet.save
        format.html { redirect_to request.referrer, notice: "Pet added to your liked pets." }
        format.turbo_stream
      else
        format.html { redirect_to request.referrer, alert: "Error, pet was not added to your liked pets." }
        format.turbo_stream
      end
    end
  end

  def destroy
    @liked_pet = LikedPet.find(application_params[:id])
    @pet = @liked_pet.pet
    authorize! @liked_pet, with: LikedPetPolicy

    respond_to do |format|
      if @liked_pet.destroy
        format.html { redirect_to request.referrer, notice: "Pet removed from your liked pets." }
        format.turbo_stream
      else
        format.html { redirect_to request.referrer, alert: "Error, pet was not removed from your liked pets." }
        format.turbo_stream
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
