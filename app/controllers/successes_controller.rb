class SuccessesController < ApplicationController
  def index
    adoptions = Adoption.includes(:dog, adopter_account: { adopter_profile: :location })
    @map_collection = GoogleMap.call(adoptions:).metadata
  end
end
