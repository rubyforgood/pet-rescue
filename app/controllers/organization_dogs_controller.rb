class OrganizationDogsController < ApplicationController
  before_action :verified_staff
  after_action :set_reason_paused_to_none, only: [:update]

  def index
    @unadopted_dogs = Dog.unadopted_dogs(current_user.staff_account.organization_id)
    @adopted_dogs = Dog.adopted_dogs(current_user.staff_account.organization_id)
    @dog = selected_dog
  end

  def new
    @dog = Dog.new
  end

  def edit
    @dog = Dog.find(params[:id])
    return if dog_in_same_organization?(@dog.organization_id)

    redirect_to dogs_path, alert: 'This dog is not in your organization.'
  end

  def show
    @dog = Dog.find(params[:id])
    @pause_reason = @dog.pause_reason
    return if dog_in_same_organization?(@dog.organization_id)

    redirect_to dogs_path, alert: 'This dog is not in your organization.'
  end

  def create
    @dog = Dog.new(dog_params)

    if @dog.save
      redirect_to dogs_path, notice: 'Dog saved successfully.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @dog = Dog.find(params[:id])

    if dog_in_same_organization?(@dog.organization_id) && @dog.update(dog_params)
      redirect_to @dog, notice: 'Dog updated successfully.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @dog = Dog.find(params[:id])

    if dog_in_same_organization?(@dog.organization_id) && @dog.destroy
      redirect_to dogs_path, notice: 'Dog deleted.', status: :see_other
    else
      redirect_to dogs_path, alert: 'Error.'
    end
  end

  private

  def dog_params
    params.require(:dog).permit(:organization_id,
                                :name,
                                :age,
                                :age_unit,
                                :sex,
                                :breed,
                                :size,
                                :description,
                                :application_paused,
                                :pause_reason,
                                append_images: [])
  end

  def selected_dog
    return if !params[:dog_id] || params[:dog_id] == ''

    Dog.where(id: params[:dog_id])
  end

  # update Dog pause_reason to not paused if applications resumed
  def set_reason_paused_to_none
    dog = Dog.find(params[:id])

    return unless dog.application_paused == false

    dog.pause_reason = 0
    dog.save!
  end
end
