# frozen_string_literal: true

require "test_helper"
require "shared/avatarable_shared_tests"

class UserTest < ActiveSupport::TestCase
  include AvatarableSharedTests

  context "associations" do
    should have_one(:staff_account).dependent(:destroy)
    should have_one(:adopter_foster_account).dependent(:destroy)
  end

  context "validations" do
    should validate_presence_of(:first_name)
    should validate_presence_of(:last_name)
    should validate_presence_of(:email)

    should "validate uniqueness of email scoped to organization" do
      user = create(:user)
      assert user.valid?

      user2 = build(:user, email: user.email)
      assert user2.invalid?
    end
  end

  context ".organization_staff" do
    should "return all users with staff accounts" do
      user = create(:staff)
      organization = user.staff_account.organization
      assert_includes User.organization_staff(organization.id), user

      user.staff_account.destroy
      assert_not_includes User.organization_staff(organization.id), user
    end
  end

  private

  def fixture_file
    @fixture_file ||= load_file
  end

  def load_file
    fixture_path = File.join(Rails.root, "test", "fixtures", "files", "logo.png")
    File.open(fixture_path)
  end
end
