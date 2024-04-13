require "test_helper"

# See https://actionpolicy.evilmartians.io/#/testing?id=testing-policies
class Organizations::AdoptablePetPolicyTest < ActiveSupport::TestCase
  include PetRescue::PolicyAssertions

  context "relation_scope" do
    setup do
      @user = build_stubbed(:user)
      @policy = Organizations::AdoptablePetPolicy.new(Pet, user: @user)
      @unadopted_pet = create(:pet)
      @adopted_pet = create(:pet, :adopted)
    end

    should "return published pets where missing match" do
      expected = [@unadopted_pet].map(&:id)

      scoped = @policy
        .apply_scope(Pet.all, type: :active_record_relation)
        .pluck(:id)

      assert_equal scoped, expected
    end
  end

  context "#show?" do
    setup do
      @policy = -> { Organizations::AdoptablePetPolicy.new(@pet, user: @user) }
      @action = -> { @policy.call.apply(:show?) }
    end

    context "when pet is not published" do
      setup do
        @pet = create(:pet, published: false)
      end

      context "when user is nil" do
        setup do
          @user = nil
        end

        should "return false" do
          assert_equal @action.call, false
        end
      end

      context "when user is adopter" do
        setup do
          @user = create(:adopter, :with_profile)
        end

        should "return false" do
          assert_equal @action.call, false
        end
      end

      context "when user is staff" do
        setup do
          @user = create(:staff)
        end

        should "return true" do
          assert_equal @action.call, true
        end
      end
    end

    context "when pet is published" do
      setup do
        @pet = create(:pet, published: true)
        @user = nil
      end

      should "return true" do
        assert_equal @action.call, true
      end
    end

    context "when pet already has a match" do
      setup do
        @pet = create(:pet, :adopted)
        @user = create(:adopter, :with_profile)
      end

      should "return false" do
        assert_equal @action.call, false
      end
    end
  end
end
