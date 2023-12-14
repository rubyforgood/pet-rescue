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

  context "DELETE #purge" do
    should "deletes the attachment and redirects to request referrer with flash" do
      image = fixture_file_upload("test.png", "image/png")

      assert_difference("@pet.images.count", 1) do
        post attach_images_pet_path(@pet),
          params: {pet: {images: [image]}}
      end

      @pet.reload
      attachment_id = @pet.images.first.id

      assert_difference("@pet.images.count", -1) do
        delete purge_attachment_path(attachment_id),
          headers: {"HTTP_REFERER" => "http://www.example.com/"}
      end

      assert_response :redirect
      follow_redirect!
      assert_equal "Attachment removed", flash[:notice]
    end
  end

  context "GET #download" do
    should "send the file for download" do
      file = fixture_file_upload("test.png", "image/png")
      @pet.files.attach(file)
      @attachment = @pet.files.last

      get download_attachment_path(@attachment.id)
      assert_response :success

      # Checks that the response contains the expected headers
      assert @response.headers["Content-Disposition"].present?
    end
  end
end
