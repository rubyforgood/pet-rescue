# == Schema Information
#
# Table name: locations
#
#  id             :bigint           not null, primary key
#  city_town      :string
#  country        :string
#  latitude       :float
#  longitude      :float
#  province_state :string
#  zipcode        :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class Location < ApplicationRecord
  has_one :adopter_profile
  geocoded_by :address
  after_validation :geocode

  # create address string for Geocoder gem to get Lat/Long
  def address
    [city_town, province_state, country].compact.join(", ")
  end

  validates :country, presence: {message: "Please enter a country"},
    length: {maximum: 50, message: "50 characters maximum"}
  validates :city_town, presence: {message: "Please enter a city or town"},
    length: {maximum: 50, message: "50 characters maximum"}
  validates :province_state, presence: {message: "Please enter a province or state"},
    length: {maximum: 50, message: "50 characters maximum"}

  # custom error messages for adopter profile validations
  def custom_messages(attribute)
    errors.where(attribute)
  end
end
