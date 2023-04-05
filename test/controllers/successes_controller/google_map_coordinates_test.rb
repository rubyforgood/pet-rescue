require 'test_helper'
require_relative '../../../app/controllers/successes_controller/google_map_coordinates'

class SuccessesController::GoogleMapCoordinatesTest < ActiveSupport::TestCase
    test "initializes instance variables as expected" do
        instance = SuccessesController::GoogleMapCoordinates.new
        assert_equal instance.map_collection, []
    end
end
