class Organizations::AdopterFosterer::LikesController < Organizations::BaseController
  before_action :authenticate_user!
  before_action :set_pet, only: [:create]
  before_action :set_like, only: [:destroy]
  layout "adopter_foster_dashboard", only: :index

  def index
    authorize! with: Organizations::LikePolicy

    @likes = current_user.adopter_foster_account.likes
    @pets = current_user.adopter_foster_account.liked_pets
  end

  def create
    authorize! context: {pet: @pet}, with: Organizations::LikePolicy

    @like = Like.new(adopter_foster_account_id: current_user.adopter_foster_account.id,
      pet_id: like_params[:pet_id])

    respond_to do |format|
      if @like.save
        format.html { redirect_to request.referrer, notice: t("organizations.adopter_fosterer.likes.create.success", name: @pet.name) }
        format.turbo_stream { flash.now[:notice] = t("organizations.adopter_fosterer.likes.create.success", name: @pet.name) }
      else
        format.html { redirect_to request.referrer, alert: t("organizations.adopter_fosterer.likes.create.failed", name: @pet.name) }
        format.turbo_stream { flash.now[:alert] = t("organizations.adopter_fosterer.likes.create.failed", name: @pet.name) }
      end
    end
  end

  def destroy
    @pet = @like.pet
    authorize! context: {pet: @pet}, with: Organizations::LikePolicy

    respond_to do |format|
      if @like.destroy
        format.html { redirect_to request.referrer, notice: t("organizations.adopter_fosterer.likes.destroy.success", name: @pet.name) }
        format.turbo_stream { flash.now[:notice] = t("organizations.adopter_fosterer.likes.destroy.success", name: @pet.name) }
      else
        format.html { redirect_to request.referrer, alert: t("organizations.adopter_fosterer.likes.destroy.failed", name: @pet.name) }
        format.turbo_stream { flash.now[:alert] = t("organizations.adopter_fosterer.likes.destroy.failed", name: @pet.name) }
      end
    end
  end

  private

  def like_params
    params.require(:like).permit(:pet_id)
  end

  def set_pet
    @pet = Pet.find(like_params[:pet_id])
  end

  def set_like
    @like = Like.find(params[:id])
  end
end
