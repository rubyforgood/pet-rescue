require "test_helper"

class OrgDogsTest < ActionDispatch::IntegrationTest

  setup do
    @dog_id = Dog.find_by(name: 'Deleted').id
  end

  teardown do
    :after_teardown
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

  test "verified staff can unpause a paused dog and the pause reason reverts to not paused" do
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
          application_paused: 'true',
          pause_reason: 'paused_until_further_notice'
        }
      }

    dog_paused = Dog.find(@dog_id)
    assert_response :redirect
    follow_redirect!
    assert_equal 'Dog updated successfully.', flash[:notice]
    assert_equal dog_paused.application_paused, true
    assert_equal dog_paused.pause_reason, 'paused_until_further_notice'

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

    dog_not_paused = Dog.find(@dog_id)
    assert_response :redirect
    follow_redirect!
    assert_equal 'Dog updated successfully.', flash[:notice]
    assert_equal dog_not_paused.application_paused, false
    assert_equal dog_not_paused.pause_reason, 'not_paused'
  end

  test "verified user can upload multiple images and delete one of the images" do
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
          append_images:
          [
            fixture_file_upload("test.png", "image/png"),
            fixture_file_upload("test2.png", "image/png")
          ]
        }
      }

    dog = Dog.find(@dog_id)
    assert_equal dog.images_attachments.length, 2
    images = dog.images_attachments

    delete "/attachments/#{images[1].id}/purge",
      params: { id: "#{images[1].id}" },
      headers: { "HTTP_REFERER" => "http://www.example.com/dogs/#{@dog_id}" }

    assert_response :redirect
    follow_redirect!
    assert_equal 'Attachment removed', flash[:notice]

    dog_again = Dog.find(@dog_id)
    assert_equal dog_again.images_attachments.length, 1
  end

  test "verified staff can delete dog post" do
    sign_in users(:user_two)

    delete "/dogs/#{@dog_id}"

    assert_response :redirect
    follow_redirect!
    assert_select "h1", "Our dogs"
  end
end
