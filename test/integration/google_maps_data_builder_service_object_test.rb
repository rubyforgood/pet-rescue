require "test_helper"

class GoogleMapsDataBuilderServiceObjectTest < ActionDispatch::IntegrationTest
  test "should return array of hashes with latitude, longitude, pet_name, and breed" do
    create(:match)
    adoptions = Match.includes(:pet, adopter_account: {adopter_profile: :location})

    result = GoogleMap::DataBuilder.new(adoptions).data

    assert_instance_of Array, result
    assert_instance_of Hash, result.first
    assert_equal %i[latitude longitude pet_name breed], result.first.keys
  end
end
