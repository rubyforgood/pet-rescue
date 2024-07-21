require "test_helper"

class OrganizationTest < ActiveSupport::TestCase
  context "associations" do
    subject { build(:organization) }

    should have_many(:staff_accounts)
    should have_many(:users).through(:staff_accounts)
    should have_many(:pets)
    should have_many(:faqs)
    should have_many(:form_answers).dependent(:destroy)
    should have_many(:people)

    should have_one(:profile).dependent(:destroy).required
    should have_one(:form_submission).dependent(:destroy)
    should have_one(:custom_page).dependent(:destroy)
  end
end
