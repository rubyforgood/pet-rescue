require "application_system_test_case"

class AdopterApplicationEditTest < ApplicationSystemTestCase
  test "Clicking the information icon makes the information box appear and disappear" do
    organization = create(:organization)
    pet = create(:pet, organization: organization)
    adopter = create(:adopter_account, :with_adopter_profile)
    application = create(:adopter_application, :withdrawn, pet: pet, adopter_account: adopter)
    user = create(:user, :verified_staff, staff_account: create(:staff_account, organization: organization))
    adopter_name = adopter.user.first_name + " " + adopter.user.last_name
    sign_in user

    visit edit_adopter_application_path(application.id)

    assert_selector "h1", text: "#{adopter_name}'s application for #{pet.name}"
    assert_selector "p.explanation", count: 0

    find("img.ms-2").click do |image|
      assert_selector "p.explanation", count: 1
      image.click
      assert_selector "p.explanation", count: 0
    end
  end

  test "Application status select dropdown contains all expected options" do
    organization = create(:organization)
    pet = create(:pet, organization: organization)
    adopter = create(:adopter_account, :with_adopter_profile)
    application = create(:adopter_application, :withdrawn, pet: pet, adopter_account: adopter)
    user = create(:user, :verified_staff, staff_account: create(:staff_account, organization: organization))
    sign_in user

    visit edit_adopter_application_path(application.id)

    assert_equal page.all("select#adopter_application_status option").map(&:value),
      ["awaiting_review", "under_review", "adoption_pending", "withdrawn", "successful_applicant"]
  end
end
