require "test_helper"

class Organizations::AdoptionApplicationReviewsControllerTest < ActionDispatch::IntegrationTest
  context "Filtering adoption applications" do
    setup do
      @user = create(:user, :verified_staff)
      set_organization(@user.organization)
      sign_in @user
    end

    teardown do
      :after_teardown
    end

    context "by pet name" do
      setup do
        @pet1 = create(:pet, name: "Pango", organization: @user.staff_account.organization)
        @pet2 = create(:pet, name: "Tycho", organization: @user.staff_account.organization)
        adopter_account1 = create(:adopter_account, :with_adopter_profile, organization: @user.staff_account.organization)
        adopter_account2 = create(:adopter_account, :with_adopter_profile, organization: @user.staff_account.organization)
        create(:adopter_application, pet: @pet1, adopter_account: adopter_account1)
        create(:adopter_application, pet: @pet2, adopter_account: adopter_account2)
      end

      should "return applications for a specific pet name" do
        get adoption_application_reviews_url, params: {q: { pet_name_cont: "Pango" } }
        assert_response :success
        assert_match "Pango", @response.body
        refute_match "Tycho", @response.body
      end
    end
  end
end
