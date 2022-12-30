require "test_helper"

class OrgDogsTest < ActionDispatch::IntegrationTest

  setup do
    @dog_id = Dog.find_by(name: 'Deleted').id
  end

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

  test "unverified staff cannot post to org dogs" do
    sign_in users(:user_three)

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

  test "verified staff can edit a dog post" do 
    sign_in users(:user_two)

    patch "/dogs/#{@dog_id}",
      params: { dog:
      {
        organization_id: "#{organizations(:organization_one).id}",
        name: 'TestDog',
        age: '7',
        sex: 'Female',
        breed: 'mix',
        size: 'Medium (22-57 lb)',
        description: 'A lovely little pooch this one.',
        append_images: [''] 
      }
    }

    assert_response :redirect
    follow_redirect!
    assert_equal 'Dog updated successfully.', flash[:notice]
    assert_select "h1", "#{Dog.find(@dog_id).name}"
  end

  test "verified staff can pause dog and pause reason is selected in dropdown" do 
    sign_in users(:user_two)

    patch "/dogs/#{@dog_id}",
      params: { dog:
      {
        organization_id: "#{organizations(:organization_one).id}",
        name: 'TestDog',
        age: '7',
        sex: 'Female',
        breed: 'mix',
        size: 'Medium (22-57 lb)',
        description: 'A lovely little pooch this one.',
        application_paused: true,
        pause_reason: 'paused_until_further_notice'
      }
    }

    dog = Dog.find(@dog_id)
    assert_response :redirect
    follow_redirect!
    assert_equal 'Dog updated successfully.', flash[:notice]
    assert_equal dog.pause_reason, 'paused_until_further_notice'
    assert_equal dog.application_paused, true
    assert_select 'form' do
      assert_select 'option[selected="selected"]', 'Paused Until Further Notice'
    end
  end

  test "verified staff can unpause a dog and pause reason reverts to not paused" do
    sign_in users(:user_two)

    patch "/dogs/#{@dog_id}",
      params: { dog:
      {
        organization_id: "#{organizations(:organization_one).id}",
        name: 'TestDog',
        age: '7',
        sex: 'Female',
        breed: 'mix',
        size: 'Medium (22-57 lb)',
        description: 'A lovely little pooch this one.',
        application_paused: 'false',
        pause_reason: 'paused_until_further_notice'
      }
    }

    dog = Dog.find(@dog_id)
    assert_response :redirect
    follow_redirect!
    assert_equal 'Dog updated successfully.', flash[:notice]
    assert_equal dog.application_paused, false
    assert_equal dog.pause_reason, 'not_paused'

    # patch "/dogs/#{@dog_id}",
    #   params: { dog:
    #   {
    #     name: 'TestDog',
    #     age: '7',
    #     sex: 'Female',
    #     breed: 'mix',
    #     size: 'Medium (22-57 lb)',
    #     description: 'A lovely little pooch this one.',
    #     application_paused: 'false',
    #     pause_reason: 'paused_until_further_notice'
    #   }
    # }

    # assert_response :redirect
    # follow_redirect!
    # assert_equal 'Dog updated successfully.', flash[:notice]
    # assert_equal dog.pause_reason, 'not_paused'
  end

  # need to figure out why this image is not becoming an attachment
  # test "verified user can upload an image" do
  #   sign_in users(:user_two)

  #   patch "/dogs/#{Dog.first.id}",
  #     params: { dog:
  #     {
  #       organization_id: "#{organizations(:organization_one).id}",
  #       name: 'TestDog',
  #       age: '7',
  #       sex: 'Female',
  #       breed: 'mix',
  #       size: 'Medium (22-57 lb)',
  #       description: 'A lovely little pooch this one.',
  #       append_images: fixture_file_upload("test.png", "image/png")
  #     }
  #   }

  #   dog = Dog.first
  #   assert dog.images.attached?
  # end

  test "verified staff can delete dog post" do
    sign_in users(:user_two)

    delete "/dogs/#{@dog_id}"

    assert_response :redirect
    follow_redirect!
    assert_select "h1", "Our dogs"
  end

  # add tests to pause applications
  # add test to check filters works for adoption status and name
end
