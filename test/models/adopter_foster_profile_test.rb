require "test_helper"

class AdopterFosterProfileTest < ActiveSupport::TestCase
  test "foster_account should refer to a User" do
    profile = adopter_foster_profiles(:one)
    assert profile.foster_account.is_a?(User)
  end
end
