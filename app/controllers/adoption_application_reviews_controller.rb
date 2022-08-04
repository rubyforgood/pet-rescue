class AdoptionApplicationReviewsController < ApplicationController

  # before_action: make sure staff account otherwise redirect to root

  # @dogs query used to populate form dropdowns
  # @adopter_applications provides the query results to display
  def index
    @dogs = org_dogs_with_apps
    @adopter_applications = adopter_applications
  end

  private

  # dogs with same organization_id as current staff && have applications && have no adoption
  def org_dogs_with_apps
    Dog.where(organization_id: current_user.staff_account.organization_id)
       .includes(:adopter_applications).where.not(adopter_applications: { id: nil })
       .includes(:adoption).where(adoption: { id: nil })
  end

  # return list of applications per user's criteria to be displayed below form
  def adopter_applications

    # if params[:dog_id] == ''
    #   org_dogs_with_apps
    # elsif

    # if params for dog_id and status are both empty, 
        # rerun the @dogs query in index
        # get all applications for these dogs
    # elsif params for dog id is empty, 
        # rerun the @dogs query and query that for those with applications with matching status
        # get all applications for these dogs
    # elsif params for status is empty
        # rerun the @dogs query
        # get all applications for these dogs
    # else if params both have values
        # rerun the @dogs query and query that for dog name and application status 
        # get all applications for these dogs
  end

end
