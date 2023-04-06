require 'test_helper'
require_relative '../../../app/controllers/successes_controller/google_map_coordinates'

class SuccessesController::GoogleMapCoordinatesTest < ActiveSupport::TestCase

	setup do 
		@raw_dataset = [
		 { latitude: 51.0866897, longitude: -115.3481135 },
		 { latitude: 51.0866897, longitude: -115.3481135 },
		 { latitude: 51.0866898, longitude: -115.3481136 },
		 { latitude: 51.0866898, longitude: -115.3481136 },
		 { latitude: 51.0866899, longitude: -115.3481137 },
		 { latitude: 51.0866899, longitude: -115.3481137 },
		 { latitude: 51.0866123, longitude: -115.3481138 },
		 { latitude: 51.0866456, longitude: -115.3481139 },
		]

		@duplicates = [
			{ latitude: 51.0866897, longitude: -115.3481135 },
			{ latitude: 51.0866898, longitude: -115.3481136 },
			{ latitude: 51.0866899, longitude: -115.3481137 }
		]
	end

	test "initializes instance variables as expected" do
			instance = SuccessesController::GoogleMapCoordinates.new
			assert_equal instance.map_collection, []
			assert_equal instance.raw_collection, []
	end

	test "create raw locations method returns array of locations if not passing collection arg on init" do
			instance = SuccessesController::GoogleMapCoordinates.new
			assert_equal instance.create_raw_collection,
				[
					{
						latitude: locations(:locations_one).latitude,
						longitude: locations(:locations_one).longitude
					}
				]
	end

	test "raw collection instance var set to collection arg if passed on init" do
		instance = SuccessesController::GoogleMapCoordinates.new(@raw_dataset)
		assert_equal instance.raw_collection, @raw_dataset
	end

	test "find duplicate locations method returns array of each duplicate location" do 
		instance = SuccessesController::GoogleMapCoordinates.new(@raw_dataset)
		assert_equal instance.find_duplicate_locations, @duplicates
	end

	test "modify duplicate locations method returns array of unique locations equal in length to raw collection" do
		instance = SuccessesController::GoogleMapCoordinates.new(@raw_dataset)
		instance.find_duplicate_locations
		modified_locations = instance.modify_duplicate_locations
		assert_equal modified_locations.length, @raw_dataset.length
		assert_equal modified_locations, modified_locations.uniq
	end
end
