require "test_helper"

class CreateDogTest < ActionDispatch::IntegrationTest
  test "can create a new dog" do
    # get "/dogs/new"
    # assert_response :success

    post "/dogs",
      params: { dog: { 
                        name: "Chloe",
                        organization_id: 1,
                        age: 3,
                        breed: 'mix',
                        sex: 'female',
                        size: 'Medium (22-57 lb)',
                        description: 'A lovely little pooch this one.'
                      } }
    assert_response :redirect
    follow_redirect!
    assert_select "h1", "OUR DOGS"
  end
end
