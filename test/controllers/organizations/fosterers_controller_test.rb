require "test_helper"
require "action_policy/test_helper"

class Organizations::FosterersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @organization = ActsAsTenant.current_tenant
  end

  context "authorization" do
    include ActionPolicy::TestHelper

    context "#index" do
      should "be authorized" do
        assert_authorized_to(
          :index?, AdopterFosterAccount,
          context: {organization: @organization},
          with: Organizations::AdopterFosterAccountPolicy
        ) do
          get fosterers_url
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
            with: Organizations::AdopterFosterAccountPolicy
          ) do
            get fosterers_url
          end
        end
      end
    end
  end
end
