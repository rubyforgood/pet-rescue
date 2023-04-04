class SuccessesController
	# class to retrieve and prepare coordinates for Google Map API, used by successes controller
	class GoogleMapCoordinates
		attr_reader :map_collection

		def initialize
			@raw_collection = []
			@duplicate_locations = []
			@map_collection = []
		end

		def create_raw_collection
			Adoption.all.each do |adoption|
				lat = adoption.adopter_account.adopter_profile.location.latitude
				lon = adoption.adopter_account.adopter_profile.location.longitude
	
				unless lat.nil? || lon.nil?
					@raw_collection << {latitude: lat, longitude: lon}
				end
			end
		end

		def find_duplicate_locations
			@duplicate_locations = @raw_collection.group_by {|e| e}.select {|k,v| v.size > 1}.map(&:first)
		end
	
		def modify_duplicate_locations
			modified_collection = @raw_collection.clone
	
			@duplicate_locations.each do |location|
				count = @raw_collection.count(location)
				locations_to_modify = Array.new(count - 1, location)
	
				modified_locations = locations_to_modify.map do |loc|
					{
						latitude: loc[:latitude] + rand(-0.3..0.3),
						longitude: loc[:longitude] + rand(-0.3..0.3)
					}
				end
				modified_collection += modified_locations
			end
			modified_collection.uniq
		end

		def duplicate_locations_empty?
			@duplicate_locations.empty?
		end

		def generate_coordinates
			create_raw_collection
			find_duplicate_locations

			if duplicate_locations_empty?
				@map_collection = @raw_collection
			else
				@map_collection = modify_duplicate_locations
			end
			@map_collection
		end
	end
end
