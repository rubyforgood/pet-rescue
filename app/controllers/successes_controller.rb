class SuccessesController < ApplicationController

  def index
    @collection = create_collection_of_adoption_data
    check_if_any_locations_are_identical(@collection)
    debugger
  end

  private

  def create_collection_of_adoption_data
    collection = []
    Adoption.all.each { |record| 
      adoption_data = {
        latitude: record.adopter_account.adopter_profile.location.latitude,
        longitude: record.adopter_account.adopter_profile.location.longitude,
        dog_name: record.dog.name
      }
      collection << adoption_data
    }
    collection
  end

  def check_if_any_locations_are_identical(collection)
    
  end


end
