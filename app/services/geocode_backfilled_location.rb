# Service object to run geocoder on all backfilled locations via console
class GeocodeBackfilledLocation
  def self.create_coordinates
    Location.find_each do |location|
      location.geocode

      if location.geocoded?
        location.save
      else
        Rails.logger.error "Error geocoding Location id: #{location.id}"
      end
    end
  end
end
