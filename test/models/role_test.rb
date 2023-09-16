require "test_helper"

class RoleTest < ActiveSupport::TestCase
  def setup
    @organization = create(:organization)
    @staff_account = create(:staff_account, organization: @organization)
  end

  test "assigns the admin role to staff_account within organization scope" do
    @staff_account.add_role(:admin, @organization)

    assert @staff_account.has_role?(:admin, @organization)
  end

  test "does not assign the admin role to staff_account outside organization scope" do
    other_organization = Organization.create(name: "Other Organization")
    @staff_account.add_role(:admin, other_organization)

    refute @staff_account.has_role?(:admin, @organization)
  end

  test "removes the admin role from staff_account" do
    @staff_account.add_role(:admin, @organization)
    @staff_account.remove_role(:admin, @organization)

    refute @staff_account.has_role?(:admin, @organization)
  end
end
