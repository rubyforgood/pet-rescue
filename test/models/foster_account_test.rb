require "test_helper"

class FosterAccountTest < ActiveSupport::TestCase
  def setup
    @user = create(:user)
    @foster_account = FosterAccount.new(user: @user)
  end

  test "should be valid" do
    assert @foster_account.valid?
  end

  test "should require a user" do
    @foster_account.user = nil
    assert_not @foster_account.valid?
  end
end
