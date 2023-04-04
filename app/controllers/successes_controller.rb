class SuccessesController < ApplicationController
  def index 
    coordinates_retriever = GoogleMapCoordinates.new
    @map_collection = coordinates_retriever.generate_coordinates
  end
end
