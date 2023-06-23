require "test_helper"

class GoogleMapsDataBuilderServiceObjectTest < ActionDispatch::IntegrationTest
  test "should return array of hashes with latitude, longitude, dog_name, and breed" do
    adoptions = Adoption.includes(:dog, adopter_account: { adopter_profile: :location })
    result = GoogleMap::DataBuilder.new(adoptions).data

    assert_instance_of Array, result
    assert_instance_of Hash, result.first
    assert_equal %i[latitude longitude dog_name breed], result.first.keys
  end
end
