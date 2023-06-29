# frozen_string_literal: true

module GoogleMap
  # Generates metadata for Google Maps with dog name, breed, and location.
  class DataBuilder
    def initialize(adoptions)
      @adoptions = adoptions
    end

    def data
      generate_map_data_from_adoptions
    end

    private

    attr_accessor :location, :adoptions

    def generate_map_data_from_adoptions
      adoptions.map do |adoption|
        lat, lon = deviate_coordinates if valid_location?(adoption)
        { latitude: lat, longitude: lon, dog_name: adoption.dog.name, breed: adoption.dog.breed }
      end
    end

    def valid_location?(adoption)
      @location = adoption.adopter_account.adopter_profile.location

      location.latitude.present? && location.longitude.present?
    end

    def deviate_coordinates
      location.latitude += rand(-0.1..0.1)
      location.longitude += rand(-0.1..0.1)

      [location.latitude, location.longitude]
    end
  end
end
