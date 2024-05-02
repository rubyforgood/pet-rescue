require "test_helper"
require "action_policy/test_helper"

class Organizations::Staff::AdoptionApplicationReviewsControllerTest < ActionDispatch::IntegrationTest
  context "authorization" do
    include ActionPolicy::TestHelper

    setup do
      @organization = ActsAsTenant.current_tenant
      @adopter_application = create(:adopter_application)

      user = create(:staff)
      sign_in user
    end

    context "index" do
      should "be authorized" do
        assert_authorized_to(
          :manage?, AdopterApplication,
          context: {organization: @organization},
          with: Organizations::AdopterApplicationPolicy
        ) do
          get staff_adoption_application_reviews_url
        end
      end

      should "have authorized scope" do
        assert_have_authorized_scope(
          type: :active_record_relation,
          with: Organizations::PetPolicy
        ) do
          get staff_adoption_application_reviews_url
        end
      end
    end

    context "#edit" do
      should "be authorized" do
        assert_authorized_to(
          :manage?, @adopter_application,
          with: Organizations::AdopterApplicationPolicy
        ) do
          get edit_staff_adoption_application_review_url(@adopter_application)
        end
      end
    end

    context "#update" do
      setup do
        loop do
          @new_status = AdopterApplication.statuses.keys.sample
          break if @new_status != @adopter_application.status
        end

        @params = {
          adopter_application: {
            status: @new_status
          }
        }
      end

      should "be authorized" do
        assert_authorized_to(
          :manage?, @adopter_application,
          with: Organizations::AdopterApplicationPolicy
        ) do
          patch staff_adoption_application_review_url(@adopter_application),
            params: @params,
            headers: {"HTTP_REFERER" => "http://www.example.com/"}
        end
      end
    end
  end

  context "Filtering adoption applications" do
    setup do
      @user = create(:staff)
      sign_in @user
    end

    teardown do
      :after_teardown
    end

    context "by pet name" do
      setup do
        @pet1 = create(:pet, name: "Pango")
        @pet2 = create(:pet, name: "Tycho")
        adopter_foster_account1 = create(:adopter_foster_account, :with_profile)
        adopter_foster_account2 = create(:adopter_foster_account, :with_profile)
        create(:adopter_application, pet: @pet1, adopter_foster_account: adopter_foster_account1)
        create(:adopter_application, pet: @pet2, adopter_foster_account: adopter_foster_account2)
      end

      should "return applications for a specific pet name" do
        get staff_adoption_application_reviews_url, params: {q: {name_i_cont: "Pango"}}
        assert_response :success
        assert_select "a.link-underline.link-underline-opacity-0", text: "Pango"
        refute_match "Tycho", @response.body
      end
    end

    context "by applicant name" do
      setup do
        @pet = create(:pet)
        adopter_foster_account1 = create(:adopter_foster_account, :with_profile,
          user: create(:user, first_name: "David", last_name: "Attenborough"))
        adopter_foster_account2 = create(:adopter_foster_account, :with_profile,
          user: create(:user, first_name: "Jane", last_name: "Goodall"))
        create(:adopter_application, pet: @pet, adopter_foster_account: adopter_foster_account1)
        create(:adopter_application, pet: @pet, adopter_foster_account: adopter_foster_account2)
      end

      should "return applications for a specific applicant name" do
        get staff_adoption_application_reviews_url, params: {q: {adopter_applications_applicant_name_i_cont: "Attenborough"}}
        assert_response :success
        assert_select "a.link-underline.link-underline-opacity-0", text: "Attenborough, David"
        refute_match "Goodall, Jane", @response.body
      end
    end

    context "Filtering by application status" do
      setup do
        @pet = create(:pet)
        adopter_foster_account1 = create(:adopter_foster_account, :with_profile)
        adopter_foster_account2 = create(:adopter_foster_account, :with_profile)
        @application_under_review = create(:adopter_application, pet: @pet, adopter_foster_account: adopter_foster_account1, status: :under_review)
        @application_awaiting_review = create(:adopter_application, pet: @pet, adopter_foster_account: adopter_foster_account2, status: :awaiting_review)
      end

      should "return pets only with applications of the specified status" do
        get staff_adoption_application_reviews_url, params: {q: {adopter_applications_status_eq: "under_review"}}
        assert_response :success
        assert_select "button.bg-dark-info", text: "Under Review"
        assert_select "button.bg-dark-primary", text: "Awaiting Review", count: 0
      end
    end
  end
end
