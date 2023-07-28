require "test_helper"

class OrgPetsTest < ActionDispatch::IntegrationTest
  setup do
    @pet = pets(:one)
    @org_id = users(:verified_staff_one).staff_account.organization_id
  end

  teardown do
    :after_teardown
  end

  test "adopter user cannot access org pets index" do
    sign_in users(:adopter_with_profile)
    get "/pets/new"
    assert_response :redirect
    follow_redirect!
    assert_equal "/", path
    assert_equal "Unauthorized action.", flash[:alert]
  end

  test "unverified staff cannot access org pets index" do
    sign_in users(:unverified_staff)
    get "/pets/new"
    assert_response :redirect
    follow_redirect!
    assert_equal "/", path
    assert_equal "Unauthorized action.", flash[:alert]
  end

  test "unverified staff cannot post to org pets" do
    sign_in users(:unverified_staff)

    post "/pets",
      params: {pet:
        {
          organization_id: "#{organizations(:one).id}",
          name: "TestPet",
          age: "3",
          sex: "Female",
          breed: "mix",
          size: "Medium (22-57 lb)",
          description: "A lovely little pooch this one.",
          append_images: [""]
        }}

    assert_response :redirect
    follow_redirect!
    assert_equal "Unauthorized action.", flash[:alert]
  end

  test "verified staff can access org pets index" do
    sign_in users(:verified_staff_one)
    get "/pets/new"
    assert_response :success
  end

  test "verified staff can access pet/new" do
    sign_in users(:verified_staff_one)
    get "/pets/new"
    assert_response :success
  end

  test "verified staff can create a new pet post" do
    sign_in users(:verified_staff_one)

    post "/pets",
      params: {pet:
        {
          organization_id: "#{organizations(:one).id}",
          name: "TestPet",
          age: "3",
          sex: "Female",
          breed: "mix",
          size: "Medium (22-57 lb)",
          description: "A lovely little pooch this one.",
          append_images: [""]
        }}

    assert_response :redirect
    follow_redirect!
    assert_equal "Pet saved successfully.", flash[:notice]
    assert_select "h1", "Our pets"
  end

  test "verified staff can edit a pet post" do
    sign_in users(:verified_staff_one)

    patch "/pets/#{@pet.id}",
      params: {pet:
        {
          organization_id: "#{organizations(:one).id}",
          name: "TestPet",
          age: "7",
          sex: "Female",
          breed: "mix",
          size: "Medium (22-57 lb)",
          description: "A lovely little pooch this one.",
          append_images: [""]
        }}

    assert_response :redirect
    follow_redirect!
    assert_equal "Pet updated successfully.", flash[:notice]
    assert_select "h1", "TestPet"
  end

  test "verified staff can pause pet" do
    sign_in users(:verified_staff_one)

    patch "/pets/#{@pet.id}",
      params: {pet: {
        application_paused: true
      }}

    assert_response :redirect
    follow_redirect!
    assert_equal "Pet updated successfully.", flash[:notice]
    @pet.reload

    assert @pet.application_paused
  end

  test "in dropdown, pause reason is selected for paused pet" do
    sign_in users(:verified_staff_one)

    patch "/pets/#{@pet.id}",
      params: {pet:
        {
          application_paused: true,
          pause_reason: "paused_until_further_notice"
        }}

    assert_response :redirect
    follow_redirect!
    assert_equal "Pet updated successfully.", flash[:notice]

    assert_select "form" do
      assert_select 'option[selected="selected"]', "Paused Until Further Notice"
    end
  end

  test "verified staff can unpause a paused pet" do
    @pet = pets(:paused_application)
    sign_in users(:verified_staff_one)

    assert @pet.application_paused

    patch "/pets/#{@pet.id}",
      params: {pet:
        {
          application_paused: "false"
        }}

    assert_response :redirect
    follow_redirect!
    assert_equal "Pet updated successfully.", flash[:notice]
    @pet.reload

    assert_not @pet.application_paused
    assert_equal @pet.pause_reason, "not_paused"
  end

  test "verified staff can upload multiple images" do
    sign_in users(:verified_staff_one)

    assert_difference "@pet.images_attachments.length", 2 do
      patch "/pets/#{@pet.id}",
        params: {pet:
                  {
                    append_images:
                    [
                      fixture_file_upload("test.png", "image/png"),
                      fixture_file_upload("test2.png", "image/png")
                    ]
                  }}

      @pet.reload
    end
  end

  test "verified staff can delete an image" do
    sign_in users(:verified_staff_one)
    pet_image = @pet.images_attachments.first

    assert_difference "@pet.images_attachments.length", -1 do
      delete "/attachments/#{pet_image.id}/purge",
        params: {id: "#{pet_image.id}"},
        headers: {"HTTP_REFERER" => "http://www.example.com/pets/#{@pet.id}"}

      assert_response :redirect
      follow_redirect!
      assert_equal "Attachment removed", flash[:notice]

      @pet.reload
    end
  end

  test "user that is not verified staff cannot delete an image attachment" do
    sign_in users(:adopter_with_profile)
    pet_image = @pet.images_attachments.first

    assert_no_difference "@pet.images_attachments.length" do
      delete "/attachments/#{pet_image.id}/purge",
        params: {id: "#{pet_image.id}"},
        headers: {"HTTP_REFERER" => "http://www.example.com/pets/#{@pet.id}"}

      follow_redirect!
      assert_equal "/", path
      assert_equal "Unauthorized action.", flash[:alert]

      @pet.reload
    end
  end

  test "verified staff can delete pet post" do
    sign_in users(:verified_staff_one)

    delete "/pets/#{@pet.id}"

    assert_response :redirect
    follow_redirect!
    assert_select "h1", "Our pets"
  end

  # test org pets index page filter for adoption status
  test "verified staff accessing org pets index without selection param see all unadopted pets" do
    sign_in users(:verified_staff_one)

    get "/pets"
    assert_response :success
    assert_select "div.col-lg-4", {count: Pet.unadopted_pets(@org_id).count}
  end

  test "verified staff accessing org pets index with selection param seeking adoption see all unadopted pets" do
    sign_in users(:verified_staff_one)
    get "/pets",
      params: {selection: "Seeking Adoption"}
    assert_response :success
    assert_select "div.col-lg-4", {count: Pet.unadopted_pets(@org_id).count}
  end

  test "verified staff accessing org pets index with selection param adopted see all adopted pets" do
    sign_in users(:verified_staff_one)
    get "/pets",
      params: {selection: "Adopted"}
    assert_response :success
    assert_select "div.col-lg-4", {count: Pet.adopted_pets(@org_id).count}
  end

  # test org pets index page filter for pet name
  test "verified staff accessing org pets index with a pet id see that pet only" do
    sign_in users(:verified_staff_one)
    get "/pets",
      params: {pet_id: @pet.id}
    assert_response :success
    assert_select "div.col-lg-4", {count: 1}
    assert_select "h5", "Applications"
  end
end
