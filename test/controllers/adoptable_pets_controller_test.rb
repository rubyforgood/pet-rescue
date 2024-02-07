require "test_helper"
require "action_policy/test_helper"

class AdoptablePetsControllerTest < ActionDispatch::IntegrationTest
  include ActionPolicy::TestHelper

  setup do
    @pet = create(:pet)
  end

  context "#show" do
    should "be authorized" do
      assert_authorized_to(:show?, @pet, with: AdoptablePetPolicy) do
        get adoptable_pet_path(@pet)
      end
    end
  end
end
