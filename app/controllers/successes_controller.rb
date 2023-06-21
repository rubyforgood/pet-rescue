class SuccessesController < ApplicationController
  def index
    adoptions = Adoption.eager_load(:dog, adopter_account: { adopter_profile: :location })
    @google_map_metadata = GoogleMapsDataBuilder.new(adoptions).data
  end
end
