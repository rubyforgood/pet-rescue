class AdoptionApplicationReviewsController < ApplicationController

  # before_action: make sure staff account otherwise redirect to root

  # @dogs query used to populate form dropdowns
  # @adopter_applications provides the query results to display
  def index
    @dogs = all_org_dogs_with_apps
    @dog = selected_dog
  end

  def edit
    @application = AdopterApplication.find(params[:id])
  end

  def update

  end

  private

  def selected_dog
    return if !params[:dog_id] || params[:dog_id] == ''

    Dog.find(params[:dog_id])
  end

  # dogs with same organization_id as current staff && have applications && have no adoption
  def all_org_dogs_with_apps
    Dog.where(organization_id: current_user.staff_account.organization_id)
       .includes(:adopter_applications).where.not(adopter_applications: { id: nil })
       .includes(:adoption).where(adoption: { id: nil })
  end

end
