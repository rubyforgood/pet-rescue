class Location < ApplicationRecord
  belongs_to :adopter_profile
  validates :city_town, presence: true
  geocoded_by :address
  after_validation :geocode

  # create address string for Geocoder gem to get Lat/Long
  def address
    [self.city_town, self.province_state, self.country].compact.join(', ')
  end
end
