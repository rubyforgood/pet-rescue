class AdoptionApplicationReviewsController < ApplicationController

  def index
    # return list of dogs from staff's organization that have applications
    @dogs = Dog.includes(:adopter_applications).where.not(adopter_applications: {id: nil})

    @adopter_applications = adopter_applications
  end

  private

  def adopter_applications

  end

end
