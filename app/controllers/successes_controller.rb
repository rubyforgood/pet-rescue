class SuccessesController < ApplicationController
  def index
    adoptions = Match.eager_load(:pet, adopter_account: {adopter_profile: :location})
    @google_map_metadata = GoogleMap::DataBuilder.new(adoptions).data
  end
end
