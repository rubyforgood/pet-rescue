require "test_helper"

class LocationTest < ActiveSupport::TestCase
  context "associations" do
    should belong_to(:adopter_profile)
  end

  context "validations" do
    should validate_presence_of(:country).with_message("Please enter a country")
    should validate_length_of(:country).is_at_most(50).with_message("50 characters maximum")
    should validate_presence_of(:city_town).with_message("Please enter a city or town")
    should validate_length_of(:city_town).is_at_most(50).with_message("50 characters maximum")
    should validate_presence_of(:province_state).with_message("Please enter a province or state")
    should validate_length_of(:province_state).is_at_most(50).with_message("50 characters maximum")
  end
end
