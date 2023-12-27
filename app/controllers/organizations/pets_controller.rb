class Organizations::PetsController < Organizations::BaseController
  before_action :set_pet, only: [:show, :edit, :update, :destroy, :attach_images, :attach_files]
  before_action :verified_staff

  after_action :set_reason_paused_to_none, only: [:update]
  layout "dashboard"

  def index
    @q = Pet.ransack(params[:q])
    @pets = @q.result
  end

  def new
    @pet = Pet.new
  end

  def edit
    return if pet_in_same_organization?(@pet.organization_id)

    redirect_to pets_path, alert: "This pet is not in your organization."
  end

  def show
    @active_tab = determine_active_tab
    @pause_reason = @pet.pause_reason
    return if pet_in_same_organization?(@pet.organization_id)

    redirect_to pets_path, alert: "This pet is not in your organization."
  end

  def create
    transaction_success = false
    @pet = Pet.new(pet_params)

    ActiveRecord::Base.transaction do
      if @pet.save && Organizations::DefaultPetTaskService.new(@pet).create_tasks
        transaction_success = true
      else
        raise ActiveRecord::Rollback
      end
    end

    if transaction_success
      redirect_to pets_path, notice: "Pet saved successfully."
    else
      flash.now[:alert] = "Error creating pet."
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if pet_in_same_organization?(@pet.organization_id) && @pet.update(pet_params)
      respond_to do |format|
        format.html { redirect_to @pet, notice: "Pet updated successfully." }
        format.turbo_stream if params[:pet][:toggle] == "true"
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @pet = Pet.find(params[:id])

    if pet_in_same_organization?(@pet.organization_id) && @pet.destroy
      redirect_to pets_path, notice: "Pet deleted.", status: :see_other
    else
      redirect_to pets_path, alert: "Error."
    end
  end

  def attach_images
    if pet_in_same_organization?(@pet.organization_id) && @pet.images.attach(params[:pet][:images])
      redirect_to pet_path(@pet, active_tab: "photos"), notice: "Upload successful."
    else
      @active_tab = "photos"
      @pet.images.last&.purge

      render :show, status: :unprocessable_entity
    end
  end

  def attach_files
    if pet_in_same_organization?(@pet.organization_id) && @pet.files.attach(params[:pet][:files])
      redirect_to pet_path(@pet, active_tab: "files"), notice: "Upload successful."
    else
      @active_tab = "files"
      @pet.files.last.purge

      render :show, status: :unprocessable_entity
    end
  end

  private

  def pet_params
    params.require(:pet).permit(:organization_id,
      :name,
      :birth_date,
      :sex,
      :species,
      :breed,
      :description,
      :application_paused,
      :pause_reason,
      :weight_from,
      :weight_to,
      :weight_unit,
      :species,
      :placement_type,
      :toggle,
      images: [],
      files: [])
  end

  def set_pet
    @pet = Pet.find(params[:id])
  end

  # update Pet pause_reason to not paused if applications resumed
  def set_reason_paused_to_none
    return unless @pet.application_paused == false

    @pet.pause_reason = 0
    @pet.save!
  end

  def determine_active_tab
    ["tasks", "applications", "photos", "files"].include?(params[:active_tab]) ? params[:active_tab] : "overview"
  end
end
