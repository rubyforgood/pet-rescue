require "application_system_test_case"

class ChecklistTemplatesTest < ApplicationSystemTestCase
  test "visiting the index" do
    create(:checklist_template)

    visit checklist_templates_url

    assert_selector "h1", text: "Checklist templates"
  end

  test "should create checklist template" do
    checklist_template = create(:checklist_template)

    visit checklist_templates_url
    click_on "New checklist template"

    fill_in "Description", with: checklist_template.description
    fill_in "Name", with: checklist_template.name
    click_on "Create Checklist template"

    assert_text "Checklist template was successfully created"
    click_on "Back"
  end

  test "should update Checklist template" do
    checklist_template = create(:checklist_template)

    visit checklist_template_url(checklist_template)
    click_on "Edit this checklist template", match: :first

    fill_in "Description", with: checklist_template.description
    fill_in "Name", with: checklist_template.name
    click_on "Update Checklist template"

    assert_text "Checklist template was successfully updated"
    click_on "Back"
  end

  test "should destroy Checklist template" do
    checklist_template = create(:checklist_template)

    visit checklist_template_url(checklist_template)
    click_on "Destroy this checklist template", match: :first

    assert_text "Checklist template was successfully destroyed"
  end
end
