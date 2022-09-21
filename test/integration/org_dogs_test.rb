require "test_helper"

class OrgDogsTest < ActionDispatch::IntegrationTest

  test "adopter user cannot access org dogs index" do
    sign_in users(:user_one)
    get "/dogs/new"
    assert_response :redirect
    follow_redirect!
    assert_equal '/', path
    assert_equal 'Unauthorized action.', flash[:alert]
  end

  test "unverified staff cannot access org dogs index" do
    sign_in users(:user_three)
    get "/dogs/new"
    assert_response :redirect
    follow_redirect!
    assert_equal '/', path
    assert_equal 'Unauthorized action.', flash[:alert]
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

    get "/dogs/new"
    assert_response :success

    post "/dogs",
         params: { dog: 
          {
           organization_id: "#{organizations(:organization_one).id}",
           name: 'TestDog',
           age: '3',
           sex: 'Female',
           breed: 'mix',
           size: 'Medium (22-57 lb)',
           description: 'A lovely little pooch this one.',
           append_images: [''] 
          }
        }

    assert_response :redirect
    follow_redirect!
    assert_equal 'Dog saved successfully.', flash[:notice]
    assert_select "h1", "Our dogs"
  end

  # failed save

  # unverified cannot create

  # can edit dog

  # can delete dog

  # can add image

  # can delete image

end
