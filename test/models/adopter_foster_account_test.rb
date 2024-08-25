require "test_helper"

class AdopterFosterAccountTest < ActiveSupport::TestCase
  context "associations" do
    should belong_to(:user)
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
end
