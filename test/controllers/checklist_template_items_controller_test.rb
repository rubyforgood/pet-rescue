require "test_helper"

class ChecklistTemplateItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @checklist_template_item = create(:checklist_template_item)
  end

  test "should get index" do
    skip("while new ui is implemented")
    # get checklist_template_items_url
    # assert_response :success
  end

  test "should get new" do
    skip("while new ui is implemented")
    # get new_checklist_template_item_url
    # assert_response :success
  end

  test "should create checklist_template_item" do
    assert_difference("ChecklistTemplateItem.count") do
      post checklist_template_items_url, params: {checklist_template_item: {checklist_template_id: @checklist_template_item.checklist_template_id, description: @checklist_template_item.description, expected_duration_days: @checklist_template_item.expected_duration_days, name: @checklist_template_item.name, required: @checklist_template_item.required}}
    end

    assert_redirected_to checklist_template_item_url(ChecklistTemplateItem.last)
  end

  test "should show checklist_template_item" do
    skip("while new ui is implemented")
    # get checklist_template_item_url(@checklist_template_item)
    # assert_response :success
  end

  test "should get edit" do
    skip("while new ui is implemented")
    # get edit_checklist_template_item_url(@checklist_template_item)
    # assert_response :success
  end

  test "should update checklist_template_item" do
    patch checklist_template_item_url(@checklist_template_item), params: {checklist_template_item: {checklist_template_id: @checklist_template_item.checklist_template_id, description: @checklist_template_item.description, expected_duration_days: @checklist_template_item.expected_duration_days, name: @checklist_template_item.name, required: @checklist_template_item.required}}
    assert_redirected_to checklist_template_item_url(@checklist_template_item)
  end

  test "should destroy checklist_template_item" do
    assert_difference("ChecklistTemplateItem.count", -1) do
      delete checklist_template_item_url(@checklist_template_item)
    end

    assert_redirected_to checklist_template_items_url
  end
end
