require "test_helper"

class OrgDogsTest < ActionDispatch::IntegrationTest
  # setup do
  #   sign_in users(:user_two)
  # end

  test "adopter user cannot access org dogs index" do
    sign_in users(:user_one)
    get "/dogs/new"
    assert_response :redirect
    follow_redirect!
    assert_equal '/', path
  end

  test "unverified staff cannot access org dogs index" do
    sign_in users(:user_three)
    get "/dogs/new"
    assert_response :redirect
    follow_redirect!
    assert_equal '/', path
  end

  test "verified staff can access org dogs index" do
    sign_in users(:user_two)
    get "/dogs/new"
    assert_response :success
  end

  test "verified staff can access dog/new" do
    sign_in users(:user_two)
    get "/dogs/new"
    assert_response :success
  end

  test "verified staff can create a new dog post" do
    sign_in users(:user_two)

    post "/dogs",
      params: { dog: { 
                        organization_id: '1',
                        name: "Chloe",
                        age: '3',
                        sex: 'female',
                        breed: 'mix',
                        size: 'Medium (22-57 lb)',
                        description: 'A lovely little pooch this one.',
                        append_images: ['']
                      }}
    # debugger
    assert_response :redirect
    follow_redirect!
    assert_select "h1", "OUR DOGS"
  end

  # can edit dog

  # can delete dog

  # can add image

  # can delete image

end
