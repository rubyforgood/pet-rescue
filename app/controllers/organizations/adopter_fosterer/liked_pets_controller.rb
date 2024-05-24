class Organizations::AdopterFosterer::LikedPetsController < Organizations::BaseController
  before_action :authenticate_user!
  before_action :set_pet, only: [:create]
  before_action :set_liked_pet, only: [:destroy]
  layout "adopter_foster_dashboard", only: :index

  def index
    authorize! with: Organizations::LikedPetPolicy

    @liked_pets = current_user.adopter_foster_account.liked_pet_associations
    @pets = current_user.adopter_foster_account.liked_pets
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
    @pet = @liked_pet.pet
    authorize! context: {pet: @pet}, with: Organizations::LikedPetPolicy

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
    params.require(:liked_pet).permit(:pet_id)
  end

  def set_pet
    @pet = Pet.find(liked_pet_params[:pet_id])
  end

  def set_liked_pet
    @liked_pet = LikedPet.find(params[:id])
  end
end
