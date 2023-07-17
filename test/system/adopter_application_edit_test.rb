require "application_system_test_case"

class AdopterApplicationEditTest < ApplicationSystemTestCase

  setup do
    @application_id = adopter_applications(:adopter_application_three).id
    sign_in users(:verified_staff_one)
    visit edit_adopter_application_path(@application_id)
  end

  test "Clicking the information icon makes the information box appear and disappear" do
    assert_selector "h1", text: "Ben Jo's application for Adopted"
    assert_selector "p.explanation", count: 0

    find("img.ms-2").click do |image|
      assert_selector "p.explanation", count: 1
      image.click
      assert_selector "p.explanation", count: 0
    end
  end

  test "Application status select dropdown contains all expected options" do 
    assert_equal page.all('select#adopter_application_status option').map(&:value),
      ['awaiting_review', 'under_review', 'adoption_pending', 'withdrawn', 'successful_applicant']
  end
end
