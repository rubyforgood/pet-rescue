class SuccessesController
  # class to retrieve and prepare coordinates for Google Map API, used by successes controller
  class GoogleMapCoordinates
    attr_accessor :location, :map_data

    def initialize(map_data = [])
      @map_data = map_data
    end

    def genarate_map_data
      generate_map_data_from_adoptions
    end

    def generate_map_data_from_adoptions
      Adoption.all.each do |adoption|
        @location = adoption.adopter_account.adopter_profile.location

        lat, lon = deviate_coordinates if valid_location?
        @map_data << { latitude: lat, longitude: lon, dog_name: adoption.dog.name, breed: adoption.dog.breed }
      end
      @map_data
    end

    def valid_location?
      location.latitude && location.longitude
    end

    def deviate_coordinates
      location.latitude += rand(-0.1..0.1)
      location.longitude += rand(-0.1..0.1)

      [location.latitude, location.longitude]
    end
  end
end
