class SuccessesController < ApplicationController
  def index
    google_maps_coordinates = GoogleMapCoordinates.new
    @map_collection = google_maps_coordinates.genarate_map_data
  end
end
