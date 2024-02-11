class Organizations::PetsController < Organizations::BaseController
  before_action :set_pet, only: [:show, :edit, :update, :destroy, :attach_images, :attach_files]

  layout "dashboard"

  def index
    authorize! Pet, context: {organization: Current.organization}

    @q = Pet.ransack(params[:q])
    @pets = authorized_scope(@q.result)
  end

  def new
    authorize! Pet, context: {organization: Current.organization}

    @pet = Pet.new
  end

  def edit
  end

  def show
    @active_tab = determine_active_tab
  end

  def create
    @pet = Pet.new(pet_params)

    authorize! Pet, context: {organization: @pet.organization}

    ActiveRecord::Base.transaction do
      @pet.save!
      Organizations::DefaultPetTaskService.new(@pet).create_tasks
    rescue
      raise ActiveRecord::Rollback
    end

    if @pet.persisted?
      redirect_to pets_path, notice: "Pet saved successfully."
    else
      flash.now[:alert] = "Error creating pet."
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @pet.update(pet_params)
      respond_to do |format|
        format.html { redirect_to @pet, notice: "Pet updated successfully." }
        format.turbo_stream if params[:pet][:toggle] == "true"
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @pet.destroy
      redirect_to pets_path, notice: "Pet deleted.", status: :see_other
    else
      redirect_to pets_path, alert: "Error."
    end
  end

  def attach_images
    if @pet.images.attach(params[:pet][:images])
      redirect_to pet_path(@pet, active_tab: "photos"), notice: "Upload successful."
    else
      @active_tab = "photos"
      @pet.images.last&.purge

      render :show, status: :unprocessable_entity
    end
  end

  def attach_files
    if @pet.files.attach(params[:pet][:files])
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
      :published,
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

    authorize! @pet
  end

  def determine_active_tab
    ["tasks", "applications", "photos", "files"].include?(params[:active_tab]) ? params[:active_tab] : "overview"
  end
end
