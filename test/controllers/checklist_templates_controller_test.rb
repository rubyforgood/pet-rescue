require "test_helper"

class ChecklistTemplatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @checklist_template = create(:checklist_template)
  end

  test "should get index" do
    get checklist_templates_url
    assert_response :success
  end

  test "should get new" do
    get new_checklist_template_url
    assert_response :success
  end

  test "should create checklist_template" do
    assert_difference("ChecklistTemplate.count") do
      post checklist_templates_url, params: {checklist_template: {description: @checklist_template.description, name: @checklist_template.name}}
    end

    assert_redirected_to checklist_template_url(ChecklistTemplate.last)
  end

  test "should show checklist_template" do
    get checklist_template_url(@checklist_template)
    assert_response :success
  end

  test "should get edit" do
    get edit_checklist_template_url(@checklist_template)
    assert_response :success
  end

  test "should update checklist_template" do
    patch checklist_template_url(@checklist_template), params: {checklist_template: {description: @checklist_template.description, name: @checklist_template.name}}
    assert_redirected_to checklist_template_url(@checklist_template)
  end

  test "should destroy checklist_template" do
    assert_difference("ChecklistTemplate.count", -1) do
      delete checklist_template_url(@checklist_template)
    end

    assert_redirected_to checklist_templates_url
  end
end
