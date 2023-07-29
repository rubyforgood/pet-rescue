require "application_system_test_case"

class ChecklistTemplatesTest < ApplicationSystemTestCase
  setup do
    @checklist_template = checklist_templates(:one)
  end

  test "visiting the index" do
    visit checklist_templates_url
    assert_selector "h1", text: "Checklist templates"
  end

  test "should create checklist template" do
    visit checklist_templates_url
    click_on "New checklist template"

    fill_in "Description", with: @checklist_template.description
    fill_in "Name", with: @checklist_template.name
    fill_in "String", with: @checklist_template.string
    fill_in "Text", with: @checklist_template.text
    click_on "Create Checklist template"

    assert_text "Checklist template was successfully created"
    click_on "Back"
  end

  test "should update Checklist template" do
    visit checklist_template_url(@checklist_template)
    click_on "Edit this checklist template", match: :first

    fill_in "Description", with: @checklist_template.description
    fill_in "Name", with: @checklist_template.name
    fill_in "String", with: @checklist_template.string
    fill_in "Text", with: @checklist_template.text
    click_on "Update Checklist template"

    assert_text "Checklist template was successfully updated"
    click_on "Back"
  end

  test "should destroy Checklist template" do
    visit checklist_template_url(@checklist_template)
    click_on "Destroy this checklist template", match: :first

    assert_text "Checklist template was successfully destroyed"
  end
end
