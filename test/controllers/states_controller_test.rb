require "test_helper"

class StatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:adopter_with_profile)
  end

  test "should return turbo stream with the states in it" do
    name = "adopter[address_attributes][state]"
    target = "adopter_profile_location_attributes_province_state"

    get country_states_path(:country),
        headers: { "Accept" => "text/vnd.turbo-stream.html" },
        params: { country: "CA", target:, name: }

    assert_response :success
    assert_select "turbo-stream[action='replace'][target='#{target}']" do
      assert_select "template" do
        assert_select "select[name='#{name}']" do
          assert_select "option", 13
        end
      end
    end
  end
end