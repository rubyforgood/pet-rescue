class DogsController < ApplicationController
# before filter for edit, update, destroy to check user is in same organization
# before filter for all to check user is staff or admin

def index
  @dogs = Dog.where(:organization_id == current_user.staff_account.organization_id)
end

def new
  @dog = Dog.new
end

def edit
  @dog = Dog.find(params[:id])
end

def show
  @dog = Dog.find(params[:id])
end

def create
  @dog = Dog.new(dog_params)

  if @dog.save
    redirect_to root_path, notice: 'Dog saved successfully.'
  else
    render :new, status: :unprocessable_entity
  end
end

def update
  @dog = Dog.find(params[:id])

  if @dog.update(dog_params)
    redirect_to @dog
  else
    render :edit, status: :unprocessable_entity
  end
end

def destroy
  @dog = Dog.find(params[:id])
  @dog.destroy

  redirect_to root_path, status: :see_other
end

private

def dog_params
  params.require(:dog).permit(:organization_id, :name, :age)
end

end
