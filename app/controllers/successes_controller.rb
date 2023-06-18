class SuccessesController < ApplicationController
  def index
    adoptions = Adoption.includes(:dog, adopter_account: { adopter_profile: :location })
    @google_map_metadata = GoogleMap.call(adoptions:).metadata
  end
end
