require "test_helper"
require "action_policy/test_helper"

class AttachmentsControllerTest < ActionDispatch::IntegrationTest
  context "authorization" do
    include ActionPolicy::TestHelper

    setup do
      user = create(:staff)
      pet = create(:pet, :with_image)
      @attachment = pet.images.last

      sign_in user
    end

    context "#purge" do
      should "be authorized" do
        assert_authorized_to(
          :purge?, @attachment,
          with: ActiveStorage::AttachmentPolicy
        ) do
          delete purge_attachment_url(@attachment),
            headers: {"HTTP_REFERER" => "http://www.example.com/"}
        end
      end
    end
  end

  teardown do
    :after_teardown
  end

  context "DELETE #purge" do
    setup do
      @user = create(:staff)
      @pet = create(:pet)

      sign_in @user
    end

    should "deletes the attachment and redirects to request referrer with flash" do
      image = fixture_file_upload("test.png", "image/png")

      assert_difference("@pet.images.count", 1) do
        post attach_images_staff_pet_path(@pet),
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
