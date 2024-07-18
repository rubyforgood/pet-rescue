require "application_system_test_case"

class DeactivateFostererTest < ApplicationSystemTestCase
  setup do
    user = create(:staff)
    @fosterer = create(:foster_account)

    sign_in user
  end

  context "toggling" do
    should "deactivate fosterer" do
      assert_not @fosterer.deactivated?
      visit staff_fosterers_path

      within(".deactivate_toggle_#{@fosterer.id}") {
        click(".form-switch")
      }

      @fosterer.reload
      assert @fosterer.deactivated?
    end
    should "activate fosterer" do
      @fosterer.deactivate

      assert @fosterer.deactivated?
      visit staff_fosterers_path

      within(".deactivate_toggle_#{@fosterer.id}") {
        click(".form-switch")
      }

      @fosterer.reload
      assert_not @fosterer.deactivated?
    end
  end
end
