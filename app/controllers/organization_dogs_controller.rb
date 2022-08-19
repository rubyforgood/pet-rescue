class OrganizationDogsController < ApplicationController
  before_action :verified_staff

  def index
    @unadopted_dogs = unadopted_dogs
    @adopted_dogs = adopted_dogs
    @dog = selected_dog
  end

  def new
    @dog = Dog.new
  end

  def edit
    @dog = Dog.find(params[:id])
    return if same_organization?(@dog)

    redirect_to dogs_path, notice: 'Staff can only interact with dogs in their organization.'
  end

  def show
    @dog = Dog.find(params[:id])
    return if same_organization?(@dog)

    redirect_to dogs_path, notice: 'Staff can only interact with dogs in their organization.'
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

    if same_organization?(@dog) && @dog.update(dog_params)
      redirect_to @dog
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @dog = Dog.find(params[:id])

    if same_organization?(@dog) && @dog.destroy
      redirect_to dogs_path, status: :see_other
    else
      redirect_to dogs_path, notice: 'Error.'
    end
  end

  private

  def dog_params
    params.require(:dog).permit(:organization_id,
                                :name,
                                :age,
                                :sex,
                                :breed,
                                :size,
                                :description,
                                images: [])
  end

  # check before all actions that user is: signed in, staff, verified
  def verified_staff
    return if user_signed_in? &&
              current_user.staff_account &&
              current_user.staff_account.verified

    redirect_to root_path, notice: 'Unauthorized action.'
  end

  # use in update and destroy to ensure staff belongs to same org as dog
  def same_organization?(dog)
    current_user.staff_account.organization_id == dog.organization_id
  end

  def unadopted_dogs
    Dog.where(organization_id: current_user.staff_account.organization_id)
       .includes(:adoption).where(adoption: { id: nil })
  end

  def adopted_dogs
    Dog.where(organization_id: current_user.staff_account.organization_id)
       .includes(:adoption).where.not(adoption: { id: nil })
  end

  def selected_dog
    return if !params[:dog_id] || params[:dog_id] == ''

    Dog.where(id: params[:dog_id])
  end
end
