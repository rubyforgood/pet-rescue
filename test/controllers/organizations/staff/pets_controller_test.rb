require "test_helper"
require "action_policy/test_helper"

class Organizations::PetsControllerTest < ActionDispatch::IntegrationTest
  context "authorization" do
    include ActionPolicy::TestHelper

    setup do
      @organization = ActsAsTenant.current_tenant
      @pet = create(:pet, :adoption_pending, sex: "Female", species: "Dog")

      user = create(:admin)
      sign_in user
    end

    context "#index" do
      should "be authorized" do
        assert_authorized_to(
          :manage?, Pet,
          context: {organization: @organization},
          with: Organizations::PetPolicy
        ) do
          get staff_pets_url
        end
      end

      should "have authorized scope" do
        assert_have_authorized_scope(
          type: :active_record_relation, with: Organizations::PetPolicy
        ) do
          get staff_pets_url
        end
      end

      should "filter by adopted status" do 
        pet_2 = create(:pet, :adopted, name: "Cutie")
        pet_3 = create(:pet, :adoption_pending, name: "Pie")

        get staff_pets_url, params: {q: {ransack_adopted: "adopted"}}
        assert_response :success

        assert_equal 1, assigns[:pets].count
      end

      should "filter by unadopted status" do
        pet_2 = create(:pet, :adopted, name: "Cutie")
        pet_3 = create(:pet, :adoption_pending, name: "Pie")

        get staff_pets_url, params: {q: {ransack_adopted: "unadopted"}}
        assert_response :success

        assert_equal 2, assigns[:pets].count
        assert_not_includes assigns[:pets].map { |pet| pet.name }, "Cutie"
      end

      should "filter by sex" do 
        pet_2 = create(:pet, sex: "Female")
        pet_3 = create(:pet, sex: "Male")
        pet_4 = create(:pet, sex: "Female")

        get staff_pets_url, params: {q: {sex_eq: "Male"}}
        assert_response :success

        assert_equal 1, assigns[:pets].count
        assert_equal 1, assigns[:pets].select { |pet| pet.sex == "Male" }.count
      end

      should "filter by species" do 
        pet_2 = create(:pet, species: "Cat")
        pet_3 = create(:pet, species: "Dog")
        pet_4 = create(:pet, species: "Cat")

        get staff_pets_url, params: {q: {species_eq: "2"}}
        assert_response :success

        assert_equal 2, assigns[:pets].count
        assert_equal 2, assigns[:pets].select { |pet| pet.species == "Cat" }.count
      end
    end

    context "#new" do
      should "be authorized" do
        assert_authorized_to(
          :manage?, Pet,
          context: {organization: @organization},
          with: Organizations::PetPolicy
        ) do
          get new_staff_pet_url
        end
      end
    end

    context "#create" do
      setup do
        @params = {
          pet: {name: "Ein"}
        }
      end

      should "be authorized" do
        assert_authorized_to(
          :manage?, Pet,
          context: {organization: @organization},
          with: Organizations::PetPolicy
        ) do
          post staff_pets_url, params: @params
        end
      end
    end

    context "#show" do
      should "be authorized" do
        assert_authorized_to(
          :manage?, @pet, with: Organizations::PetPolicy
        ) do
          get staff_pet_url(@pet)
        end
      end
    end

    context "#edit" do
      should "be authorized" do
        assert_authorized_to(
          :manage?, @pet, with: Organizations::PetPolicy
        ) do
          get edit_staff_pet_url(@pet)
        end
      end
    end

    context "#update" do
      setup do
        @params = {pet: {weight_to: 25}}
      end

      should "be authorized" do
        assert_authorized_to(
          :manage?, @pet, with: Organizations::PetPolicy
        ) do
          patch staff_pet_url(@pet), params: @params
        end
      end
    end

    context "#destroy" do
      should "be authorized" do
        assert_authorized_to(
          :manage?, @pet, with: Organizations::PetPolicy
        ) do
          delete staff_pet_url(@pet)
        end
      end
    end

    context "#attach_images" do
      setup do
        image = fixture_file_upload("test.png", "image/png")
        @params = {
          pet: {images: [image]}
        }
      end

      should "be authorized" do
        assert_authorized_to(
          :manage?, @pet, with: Organizations::PetPolicy
        ) do
          post attach_images_staff_pet_url(@pet), params: @params
        end
      end
    end

    context "#attach_files" do
      setup do
        file = fixture_file_upload("test.png", "image/png")
        @params = {
          pet: {files: [file]}
        }
      end

      should "be authorized" do
        assert_authorized_to(
          :manage?, @pet, with: Organizations::PetPolicy
        ) do
          post attach_files_staff_pet_url(@pet), params: @params
        end
      end
    end
  end

  context "controller" do
    setup do
      @user = create(:admin)
      @pet = create(:pet)
      @default_pet_tasks = create(:default_pet_task)
      sign_in @user
    end

    teardown do
      :after_teardown
    end

    context "POST #attach_images" do
      should "attaches an image and redirects to pet photos tab with success flash" do
        image = fixture_file_upload("test.png", "image/png")

        assert_difference("@pet.images.count", 1) do
          post attach_images_staff_pet_path(@pet),
            params: {pet: {images: [image]}}
        end

        assert_response :redirect
        follow_redirect!
        assert_equal "Upload successful.", flash.notice
        assert_equal "active_tab=photos", URI.decode_www_form(URI.parse(request.url).query).join("=")
      end
    end

    context "POST #attach_files" do
      should "attaches a record and redirects to pet files tab with success flash" do
        file = fixture_file_upload("test.png", "image/png")

        assert_difference("@pet.files.count", 1) do
          post attach_files_staff_pet_path(@pet),
            params: {pet: {files: [file]}}
        end

        assert_response :redirect
        follow_redirect!
        assert_equal "Upload successful.", flash.notice
        assert_equal "active_tab=files", URI.decode_www_form(URI.parse(request.url).query).join("=")
      end
    end

    should "update application paused should respond with turbo_stream when toggled on pets page" do
      patch staff_pet_url(@pet), params: {pet: {application_paused: true, toggle: "true"}}, as: :turbo_stream

      assert_equal Mime[:turbo_stream], response.media_type
      assert_response :success
    end

    should "update application paused should respond with html when not on pets page" do
      patch staff_pet_url(@pet), params: {pet: {application_paused: true}}, as: :turbo_stream

      assert_equal Mime[:html], response.media_type
      assert_response :redirect
    end

    should "POST default pet tasks are created when pet is created" do
      assert_difference "Pet.count", 1 do
        post staff_pets_path, params:
        {
          "pet" => {
            "organization_id" => @user.organization.id.to_s,
            "name" => "Test",
            "birth_date(1i)" => "2023",
            "birth_date(2i)" => "12",
            "birth_date(3i)" => "27",
            "sex" => "male",
            "species" => "Cat",
            "breed" => "Anything",
            "weight_from" => "44",
            "weight_to" => "45",
            "weight_unit" => "lb",
            "placement_type" => "Adoptable",
            "description" => "sd",
            "application_paused" => "false",
            "published" => "false"
          }
        }
      end
      assert_equal 1, Pet.last.tasks.count
    end
  end
end
