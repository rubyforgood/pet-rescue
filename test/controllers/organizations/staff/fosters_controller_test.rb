require "test_helper"
require "action_policy/test_helper"

class Organizations::Staff::FostersControllerTest < ActionDispatch::IntegrationTest
  context "authorization" do
    include ActionPolicy::TestHelper
    context "context only action" do
      setup do
        @organization = ActsAsTenant.current_tenant
        @adopter_foster_account = create(:adopter_foster_account)
        sign_in @adopter_foster_account.user
      end

      context "#new" do
        should "be authorized" do
          assert_authorized_to(
            :manage?, Match,
            context: {organization: @organization},
            with: Organizations::MatchPolicy
          ) do
            get new_staff_manage_foster_url
          end
        end
      end

      context "#create" do
        should "be authorized" do
          assert_authorized_to(
            :manage?, Match,
            context: {organization: @organization},
            with: Organizations::MatchPolicy
          ) do
            post staff_manage_fosters_url
          end
        end
      end

      context "#index" do
        should "be authorized" do
          assert_authorized_to(
            :manage?, Match,
            context: {organization: @organization},
            with: Organizations::MatchPolicy
          ) do
            get staff_manage_fosters_url
          end
        end

        context "when user is authorized" do
          setup do
            user = create(:staff_admin)
            sign_in user
          end

          should "have authorized scope" do
            assert_have_authorized_scope(
              type: :active_record_relation,
              with: Organizations::MatchPolicy
            ) do
              get staff_manage_fosters_url
            end
          end
        end
      end
    end

    context "existing record actions" do
      setup do
        @foster = create(:foster)
        sign_in @foster.user
      end

      context "#edit" do
        should "be authorized" do
          assert_authorized_to(
            :manage?, @foster,
            with: Organizations::MatchPolicy
          ) do
            get edit_staff_manage_foster_url(@foster)
          end
        end
      end

      context "#update" do
        should "be authorized" do
          assert_authorized_to(
            :manage?, @foster,
            with: Organizations::MatchPolicy
          ) do
            patch staff_manage_foster_url(@foster)
          end
        end
      end

      context "#destroy" do
        should "be authorized" do
          assert_authorized_to(
            :manage?, @foster,
            with: Organizations::MatchPolicy
          ) do
            delete staff_manage_foster_url(@foster)
          end
        end
      end
    end
  end
end
