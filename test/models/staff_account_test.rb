# frozen_string_literal: true

require "test_helper"

class StaffAccountTest < ActiveSupport::TestCase
  context "#deactivate" do
    should "set deactivated_at" do
      staff_account = create(:staff_account)

      staff_account.deactivate
      assert_not_nil(staff_account.deactivated_at)
    end
  end

  context "#activate" do
    should "set deactivated_at to nil" do
      staff_account = create(:staff_account)

      staff_account.activate
      assert_nil(staff_account.deactivated_at)
    end
  end
end
