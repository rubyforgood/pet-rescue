require "test_helper"

class OrgDogsTest < ActionDispatch::IntegrationTest

  setup do
    @dog = dogs(:one)
    @org_id = users(:verified_staff_one).staff_account.organization_id
  end

  teardown do
    :after_teardown
  end

  test "adopter user cannot access org dogs index" do
    sign_in users(:adopter_with_profile)
    get "/dogs/new"
    assert_response :redirect
    follow_redirect!
    assert_equal '/', path
    assert_equal 'Unauthorized action.', flash[:alert]
  end

  test "unverified staff cannot access org dogs index" do
    sign_in users(:unverified_staff)
    get "/dogs/new"
    assert_response :redirect
    follow_redirect!
    assert_equal '/', path
    assert_equal 'Unauthorized action.', flash[:alert]
  end

  test "unverified staff cannot post to org dogs" do
    sign_in users(:unverified_staff)

    post "/dogs",
      params: { dog:
        {
          organization_id: "#{organizations(:one).id}",
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
    sign_in users(:verified_staff_one)
    get "/dogs/new"
    assert_response :success
  end

  test "verified staff can access dog/new" do
    sign_in users(:verified_staff_one)
    get "/dogs/new"
    assert_response :success
  end

  test "verified staff can create a new dog post" do
    sign_in users(:verified_staff_one)

    post "/dogs",
      params: { dog:
        {
          organization_id: "#{organizations(:one).id}",
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
    sign_in users(:verified_staff_one)

    patch "/dogs/#{@dog.id}",
      params: { dog:
        {
          organization_id: "#{organizations(:one).id}",
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
    assert_select "h1", "TestDog"
  end

  test "verified staff can pause dog" do
    sign_in users(:verified_staff_one)

    patch "/dogs/#{@dog.id}",
      params: { dog: {
          application_paused: true
        }
      }

    assert_response :redirect
    follow_redirect!
    assert_equal 'Dog updated successfully.', flash[:notice]
    @dog.reload

    assert @dog.application_paused
  end

  test 'in dropdown, pause reason is selected for paused dog' do
    sign_in users(:verified_staff_one)

    patch "/dogs/#{@dog.id}",
      params: { dog:
        {
          application_paused: true,
          pause_reason: 'paused_until_further_notice'
        }
      }

    assert_response :redirect
    follow_redirect!
    assert_equal 'Dog updated successfully.', flash[:notice]

    assert_select 'form' do
      assert_select 'option[selected="selected"]', 'Paused Until Further Notice'
    end
  end

  test "verified staff can unpause a paused dog" do
    @dog = dogs(:paused_application)
    sign_in users(:verified_staff_one)

    assert @dog.application_paused

    patch "/dogs/#{@dog.id}",
      params: { dog:
        {
          application_paused: 'false',
        }
      }

    assert_response :redirect
    follow_redirect!
    assert_equal 'Dog updated successfully.', flash[:notice]
    @dog.reload

    assert_not @dog.application_paused
    assert_equal @dog.pause_reason, 'not_paused'
  end

  test "verified staff can upload multiple images" do
    sign_in users(:verified_staff_one)

    assert_difference '@dog.images_attachments.length', 2 do
      patch "/dogs/#{@dog.id}",
        params: { dog:
                  {
                    append_images:
                    [
                      fixture_file_upload("test.png", "image/png"),
                      fixture_file_upload("test2.png", "image/png")
                    ]
                  }
        }

      @dog.reload
    end
  end

  test "verified staff can delete an image" do
    sign_in users(:verified_staff_one)
    dog_image = @dog.images_attachments.first

    assert_difference '@dog.images_attachments.length', -1 do
      delete "/attachments/#{dog_image.id}/purge",
        params: { id: "#{dog_image.id}" },
        headers: { "HTTP_REFERER" => "http://www.example.com/dogs/#{@dog.id}" }

      assert_response :redirect
      follow_redirect!
      assert_equal 'Attachment removed', flash[:notice]

      @dog.reload
    end
  end

  test "user that is not verified staff cannot delete an image attachment" do
    sign_in users(:adopter_with_profile)
    dog_image = @dog.images_attachments.first

    assert_no_difference '@dog.images_attachments.length' do
      delete "/attachments/#{dog_image.id}/purge",
        params: { id: "#{dog_image.id}" },
        headers: { "HTTP_REFERER" => "http://www.example.com/dogs/#{@dog.id}" }

      follow_redirect!
      assert_equal '/', path
      assert_equal 'Unauthorized action.', flash[:alert]

      @dog.reload
    end
  end

  test "verified staff can delete dog post" do
    sign_in users(:verified_staff_one)

    delete "/dogs/#{@dog.id}"

    assert_response :redirect
    follow_redirect!
    assert_select "h1", "Our dogs"
  end

  # test org dogs index page filter for adoption status
  test "verified staff accessing org dogs index without selection param see all unadopted dogs" do
    sign_in users(:verified_staff_one)

    get "/dogs"
    assert_response :success
    assert_select 'div.col-lg-4', { count: Dog.unadopted_dogs(@org_id).count }
  end

  test "verified staff accessing org dogs index with selection param seeking adoption see all unadopted dogs" do
    sign_in users(:verified_staff_one)
    get "/dogs",
    params: { selection: 'Seeking Adoption' }
    assert_response :success
    assert_select 'div.col-lg-4', { count: Dog.unadopted_dogs(@org_id).count }
  end

  test "verified staff accessing org dogs index with selection param adopted see all adopted dogs" do
    sign_in users(:verified_staff_one)
    get "/dogs",
    params: { selection: 'Adopted' }
    assert_response :success
    assert_select 'div.col-lg-4', { count: Dog.adopted_dogs(@org_id).count }
  end

  # test org dogs index page filter for dog name
  test "verified staff accessing org dogs index with a dog id see that dog only" do
    sign_in users(:verified_staff_one)
    get "/dogs",
    params: { dog_id: @dog.id }
    assert_response :success
    assert_select 'div.col-lg-4', { count: 1 }
    assert_select 'h5', "Applications"
  end
end
