# frozen_string_literal: true

require "test_helper"

class DeactivateToggleComponentTest < ViewComponent::TestCase
  context "Active Account" do
    setup do
      @current_user = create(:admin)
      @account = create(:staff_account)
    end

    should "render unchecked toggle" do
      render_inline(DeactivateToggleComponent.new(account: @account, role: "staff", current_user: @current_user))

      assert_selector("input[type=checkbox]")
      assert_no_selector("input[type=checkbox][checked]")
    end

    should "Disable current user toggle" do
      render_inline(DeactivateToggleComponent.new(account: @current_user.staff_account, role: "staff", current_user: @current_user))
      assert_selector("input[type=checkbox][disabled]")
    end
  end

  context "Deactivated Account" do
    setup do
      current_user = create(:admin)
      account = create(:staff_account, :deactivated)

      render_inline(DeactivateToggleComponent.new(account: account, role: "staff", current_user: current_user))
    end

    should "render checked toggle" do
      assert_selector("input[type=checkbox][checked]")
    end
  end
end
