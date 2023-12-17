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
        get adoption_application_reviews_url, params: {q: {name_cont: "Pango"}}
        assert_response :success
        assert_match "Pango", @response.body
        refute_match "Tycho", @response.body
      end
    end

    context "by applicant name" do
      setup do
        @pet = create(:pet, organization: @user.staff_account.organization)
        adopter_account1 = create(:adopter_account, :with_adopter_profile,
          user: create(:user, first_name: "David", last_name: "Attenborough",
            organization: @user.staff_account.organization))
        adopter_account2 = create(:adopter_account, :with_adopter_profile,
          user: create(:user, first_name: "Jane", last_name: "Goodall",
            organization: @user.staff_account.organization))
        create(:adopter_application, pet: @pet, adopter_account: adopter_account1)
        create(:adopter_application, pet: @pet, adopter_account: adopter_account2)
      end

      should "return applications for a specific applicant name" do
        get adoption_application_reviews_url, params: {q: {adopter_applications_applicant_name_cont: "Attenborough"}}
        assert_response :success
        assert_match "Attenborough, David", @response.body
        refute_match "Goodall, Jane", @response.body
      end
    end

    context "Filtering by application status" do
      setup do
        @pet = create(:pet, organization: @user.staff_account.organization)
        adopter_account1 = create(:adopter_account, :with_adopter_profile, organization: @user.staff_account.organization)
        adopter_account2 = create(:adopter_account, :with_adopter_profile, organization: @user.staff_account.organization)
        @application_under_review = create(:adopter_application, pet: @pet, adopter_account: adopter_account1, status: :under_review)
        @application_awaiting_review = create(:adopter_application, pet: @pet, adopter_account: adopter_account2, status: :awaiting_review)
      end

      should "return pets only with applications of the specified status" do
        get adoption_application_reviews_url, params: {q: {adopter_applications_status_eq: "under_review"}}
        assert_response :success
        assert_select "span.badge.bg-dark-info", text: "Under Review"
        assert_select "span.badge", text: "Awaiting Review", count: 0
      end
    end
  end
end
