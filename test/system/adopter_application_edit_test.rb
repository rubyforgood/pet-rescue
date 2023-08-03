require "application_system_test_case"

class AdopterApplicationEditTest < ApplicationSystemTestCase
  test "Clicking the information icon makes the information box appear and disappear" do
    application = create(:adopter_application, :adoption_pending)
    user = create(:user, :verified_staff)
    sign_in user

    visit edit_adopter_application_path(application.id)

    assert_selector "h1", text: "Ben Jo's application for Adopted"
    assert_selector "p.explanation", count: 0

    find("img.ms-2").click do |image|
      assert_selector "p.explanation", count: 1
      image.click
      assert_selector "p.explanation", count: 0
    end
  end

  # test "Application status select dropdown contains all expected options" do
  #   application = create(:adopter_application, :adoption_pending)
  #   user = create(:user, :verified_staff)
  #   sign_in user

  #   visit edit_adopter_application_path(application.id)

  #   assert_equal page.all("select#adopter_application_status option").map(&:value),
  #     ["awaiting_review", "under_review", "adoption_pending", "withdrawn", "successful_applicant"]
  # end
end
