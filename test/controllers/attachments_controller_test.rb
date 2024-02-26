require "test_helper"

class Organizations::PetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:staff)
    @pet = create(:pet, organization: @user.staff_account.organization)
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
end
