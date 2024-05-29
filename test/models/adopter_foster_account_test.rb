require "test_helper"

class AdopterFosterAccountTest < ActiveSupport::TestCase
  context "associations" do
    should belong_to(:user)
    should have_one(:adopter_foster_profile).dependent(:destroy)
    should have_many(:adopter_applications).dependent(:destroy)
    should have_many(:matches).dependent(:destroy)
  end

  context "scopes" do
    setup do
      @adopter = create(:adopter)
      @foster = create(:fosterer)
    end

    context ".adopters" do
      should "include accounts with adopter role only" do
        res = AdopterFosterAccount.adopters
        assert res.include?(@adopter.adopter_foster_account)
        assert_not res.include?(@foster.adopter_foster_account)
      end
    end

    context ".fosterers" do
      should "include accounts with fosterer role only" do
        res = AdopterFosterAccount.fosterers
        assert res.include?(@foster.adopter_foster_account)
        assert_not res.include?(@adopter.adopter_foster_account)
      end
    end
  end
end
