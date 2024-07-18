require "test_helper"

class AdopterFosterAccountTest < ActiveSupport::TestCase
  context "associations" do
    should belong_to(:user)
    should have_one(:adopter_foster_profile).dependent(:destroy)
    should have_many(:adopter_applications).dependent(:destroy)
    should have_many(:matches).dependent(:destroy)
    should have_many(:likes).dependent(:destroy)
    should have_many(:liked_pets).through(:likes).source(:pet)
  end

  context "scopes" do
    setup do
      @adopter = create(:adopter)
      @fosterer = create(:fosterer)
    end

    context ".adopters" do
      should "include accounts with adopter role" do
        res = AdopterFosterAccount.adopters
        assert res.include?(@adopter.adopter_foster_account)
        assert res.include?(@fosterer.adopter_foster_account)
      end
    end

    context ".fosterers" do
      should "include accounts with fosterer role" do
        res = AdopterFosterAccount.fosterers
        assert res.include?(@fosterer.adopter_foster_account)
        assert_not res.include?(@adopter.adopter_foster_account)
      end
    end
  end

  context "#deactivate" do
    should "set deactivated_at" do
      fosterer = create(:foster_account)

      fosterer.deactivate
      assert_not_nil(fosterer.deactivated_at)
    end
  end

  context "#activate" do
    should "set deactivated_at to nil" do
      fosterer = create(:foster_account)

      fosterer.activate
      assert_nil(fosterer.deactivated_at)
    end
  end

  context "#deactivated?" do
    should "return true if deactivated_at is not nil" do
      fosterer = create(:foster_account, :deactivated)

      assert(fosterer.deactivated?)
    end

    should "return false if deactivated_at is nil" do
      fosterer = create(:foster_account)

      assert_not(fosterer.deactivated?)
    end
  end
end
