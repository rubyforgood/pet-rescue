class Organizations::AdopterFosterer::LikedPetsController < Organizations::BaseController
  before_action :authenticate_user!
  before_action :set_pet, only: [:create]
  layout "adopter_foster_dashboard", only: :index

  def index
    authorize! with: Organizations::LikedPetPolicy

    @liked_pets = LikedPet.where(adopter_foster_account_id: current_user&.adopter_foster_account&.id)
    @pets = Pet.find(@liked_pets.pluck(:pet_id))
  end

  def create
    authorize! context: {pet: @pet}, with: Organizations::LikedPetPolicy

    @liked_pet = LikedPet.new(adopter_foster_account_id: current_user.adopter_foster_account.id,
      pet_id: liked_pet_params[:pet_id])

    respond_to do |format|
      if @liked_pet.save
        format.html { redirect_to request.referrer, notice: "#{@pet.name} added to your liked pets." }
        format.turbo_stream { flash.now[:notice] = "#{@pet.name} added to your liked pets." }
      else
        format.html { redirect_to request.referrer, alert: "Error, pet was not added to your liked pets." }
        format.turbo_stream { flash.now[:alert] = "Error, pet was not added to your liked pets." }
      end
    end
  end

  def destroy
    @liked_pet = LikedPet.find(liked_pet_params[:id])
    @pet = @liked_pet.pet
    authorize! context: {pet: @liked_pet.pet}, with: Organizations::LikedPetPolicy

    respond_to do |format|
      if @liked_pet.destroy
        format.html { redirect_to request.referrer, notice: "#{@pet.name} removed from your liked pets." }
        format.turbo_stream { flash.now[:notice] = "#{@pet.name} removed from your liked pets." }
      else
        format.html { redirect_to request.referrer, alert: "Error, pet was not removed from your liked pets." }
        format.turbo_stream { flash.now[:alert] = "Error, pet was not removed from your liked pets." }
      end
    end
  end

  private

  def liked_pet_params
    params.permit(:pet_id, :id, :_method, :authenticity_token)
  end

  def set_pet
    @pet = Pet.find(liked_pet_params[:pet_id])
  end
end
