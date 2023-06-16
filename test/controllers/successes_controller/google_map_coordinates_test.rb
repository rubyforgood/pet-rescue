# frozen_string_literal: true

require 'test_helper'
require_relative '../../../app/controllers/successes_controller/google_map_coordinates'

class SuccessesController::GoogleMapCoordinatesTest < ActiveSupport::TestCase
	attr_accessor :location_one, :adoption_one

	setup do
		@location_one = locations(:locations_one)
		@adoption_one = adoptions(:adoption_one)
	end

	test 'genarate_map_data method returns an array of hashes with the correct keys' do
		instance = SuccessesController::GoogleMapCoordinates.new
		result = instance.genarate_map_data

		assert_instance_of Array, result
		assert_instance_of Hash, result.first
		assert_equal %i[latitude longitude dog_name breed], result.first.keys
	end
end
