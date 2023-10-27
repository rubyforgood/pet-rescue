require "test_helper"
class Organizations::PetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user, :verified_staff)
    @pet = create(:pet, organization: @user.staff_account.organization)
    sign_in @user
  end

  context "POST #update_images" do
    should "redirect to pet page" do
      image = fixture_file_upload('buster1.jpg', 'image/jpeg')

      post update_images_pet_path(@pet), 
      params: {append_images: [image]}

      assert_response :redirect
    end
  end
end