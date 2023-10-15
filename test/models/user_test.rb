# frozen_string_literal: true

require "test_helper"

class UserTest < ActiveSupport::TestCase
  context 'avatarable' do
    should "behave as avatarable" do
      assert_includes User.included_modules, Avatarable
    
      assert subject, respond_to?(:append_avatar=)
    end

    context 'validations' do
      should 'append error if avatar is too big' do
        fixture_file.stubs(:size).returns(2.megabytes)

        subject.avatar.attach(io: fixture_file, filename: 'test.png')

        refute subject.valid?
        assert_includes subject.errors[:avatar], "size must be between 10kb and 1Mb"
      end
      
      should 'append error if avatar is too small' do
        fixture_file.stubs(:size).returns(1.kilobyte)

        subject.avatar.attach(io: fixture_file, filename: 'test.png')

        refute subject.valid?
        assert_includes subject.errors[:avatar], "size must be between 10kb and 1Mb"
      end
    end
  end

  context "associations" do
    should have_one(:staff_account).dependent(:destroy)
    should have_one(:adopter_account).dependent(:destroy)
  end

  context "validations" do
    should validate_presence_of(:first_name)
    should validate_presence_of(:last_name)
    should validate_presence_of(:email)

    should "validate uniqueness of email scoped to organization" do
      user = create(:user)
      assert user.valid?

      user2 = build(:user, email: user.email, organization: user.organization)
      assert user2.invalid?
    end
  end

  context ".organization_staff" do
    should "return all users with staff accounts" do
      user = create(:user, :verified_staff)
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
    fixture_path = File.join(Rails.root, 'test', 'fixtures', 'files', 'logo.png')
    File.open(fixture_path)
  end
end
