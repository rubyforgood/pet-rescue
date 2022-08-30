class AdoptableDogsController < ApplicationController

  # outer left join on Dog and Adoption
  def index
    @dogs = Dog.where.missing(:adoption)
  end

  def show
    @dog = Dog.find(params[:id])

    return unless @dog.adoption

    redirect_to adoptable_dogs_path, alert: 'You can only view dogs that need adoption.'
  end
end
