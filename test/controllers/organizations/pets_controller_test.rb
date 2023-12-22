require "test_helper"

class Organizations::PetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user, :verified_staff)
    @pet = create(:pet, organization: @user.staff_account.organization)
    set_organization(@user.organization)
    sign_in @user
  end

  teardown do
    :after_teardown
  end

  context "POST #attach_images" do
    should "attaches an image and redirects to pet photos tab with success flash" do
      image = fixture_file_upload("test.png", "image/png")

      assert_difference("@pet.images.count", 1) do
        post attach_images_pet_path(@pet),
          params: {pet: {images: [image]}}
      end

      assert_response :redirect
      follow_redirect!
      assert_equal flash.notice, "Upload successful."
      assert_equal URI.decode_www_form(URI.parse(request.url).query).join("="), "active_tab=photos"
    end
  end

  context "POST #attach_files" do
    should "attaches a record and redirects to pet files tab with success flash" do
      file = fixture_file_upload("test.png", "image/png")

      assert_difference("@pet.files.count", 1) do
        post attach_files_pet_path(@pet),
          params: {pet: {files: [file]}}
      end

      assert_response :redirect
      follow_redirect!
      assert_equal flash.notice, "Upload successful."
      assert_equal URI.decode_www_form(URI.parse(request.url).query).join("="), "active_tab=files"
    end
  end

  test "update application paused should respond with turbo_stream when toggled on pets page" do
    patch url_for(@pet), params: {pet: {application_paused: true, toggle: "true"}}, as: :turbo_stream

    assert_equal Mime[:turbo_stream], response.media_type
    assert_response :success
  end

  test "update application paused should respond with html when not on pets page" do
    patch url_for(@pet), params: {pet: {application_paused: true}}, as: :turbo_stream

    assert_equal Mime[:html], response.media_type
    assert_response :redirect
  end
end
