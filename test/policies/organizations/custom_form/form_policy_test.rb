require "test_helper"

module Organizations
  module CustomForm
    class FormPolicyTest < ActiveSupport::TestCase
      include PetRescue::PolicyAssertions

      context "context only action" do
        setup do
          @organization = ActsAsTenant.current_tenant
          @policy = -> { Organizations::CustomForm::FormPolicy.new(::CustomForm::Form, user: @user, organization: @organization) }
        end

        context "#manage?" do
          setup do
            @action = -> { @policy.call.apply(:manage?) }
          end

          context "when user is nil" do
            setup do
              @user = nil
            end

            should "return false" do
              assert_equal false, @action.call
            end
          end

          context "when user is adopter" do
            setup do
              @user = create(:adopter)
            end

            should "return false" do
              assert_equal false, @action.call
            end
          end

          context "when user is fosterer" do
            setup do
              @user = create(:fosterer)
            end

            should "return false" do
              assert_equal false, @action.call
            end
          end

          context "when user is deactivated staff" do
            setup do
              @user = create(:staff, :deactivated)
            end

            should "return false" do
              assert_equal false, @action.call
            end
          end

          context "when user is staff admin" do
            setup do
              @user = create(:super_admin)
            end

            should "return true" do
              assert_equal true, @action.call
            end
          end
        end

        context "#index?" do
          should "be an alias to :manage?" do
            assert_alias_rule @policy.call, :index?, :manage?
          end
        end

        context "#new?" do
          should "be an alias to :manage?" do
            assert_alias_rule @policy.call, :new?, :manage?
          end
        end

        context "#create?" do
          should "be an alias to :manage?" do
            assert_alias_rule @policy.call, :create?, :manage?
          end
        end
      end

      context "existing record action" do
        setup do
          @form = create(:form)
          @policy = -> { Organizations::CustomForm::FormPolicy.new(@form, user: @user) }
        end

        context "#manage?" do
          setup do
            @action = -> { @policy.call.apply(:manage?) }
          end

          context "when user is nil" do
            setup do
              @user = nil
            end

            should "return false" do
              assert_equal false, @action.call
            end
          end

          context "when user is adopter" do
            setup do
              @user = create(:adopter)
            end

            should "return false" do
              assert_equal false, @action.call
            end
          end

          context "when user is fosterer" do
            setup do
              @user = create(:fosterer)
            end

            should "return false" do
              assert_equal false, @action.call
            end
          end

          context "when user is deactivated staff" do
            setup do
              @user = create(:staff, :deactivated)
            end

            should "return false" do
              assert_equal false, @action.call
            end
          end

          context "when user is staff admin" do
            setup do
              @user = create(:super_admin)
            end

            should "return true" do
              assert_equal true, @action.call
            end
          end
        end

        context "#show?" do
          should "be an alias to :manage?" do
            assert_alias_rule @policy.call, :show?, :manage?
          end
        end

        context "#edit?" do
          should "be an alias to :manage?" do
            assert_alias_rule @policy.call, :edit?, :manage?
          end
        end

        context "#update?" do
          should "be an alias to :manage?" do
            assert_alias_rule @policy.call, :update?, :manage?
          end
        end
      end
    end
  end
end
