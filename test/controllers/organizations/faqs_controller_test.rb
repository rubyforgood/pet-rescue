require "test_helper"

class Organizations::FaqsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @faq = faqs(:one)
  end

  test "should get index" do
    get faqs_url
    assert_response :success
  end

  test "should get new" do
    get new_faq_url
    assert_response :success
  end

  test "should create faq" do
    assert_difference("Organizations::Faq.count") do
      post faqs_url, params: {faq: {create: @faq.create, edit: @faq.edit, index: @faq.index, new: @faq.new}}
    end

    assert_redirected_to faq_url(Organizations::Faq.last)
  end

  test "should show faq" do
    get faq_url(@faq)
    assert_response :success
  end

  test "should get edit" do
    get edit_faq_url(@faq)
    assert_response :success
  end

  test "should update faq" do
    patch faq_url(@faq), params: {faq: {create: @faq.create, edit: @faq.edit, index: @faq.index, new: @faq.new}}
    assert_redirected_to faq_url(@faq)
  end

  test "should destroy faq" do
    assert_difference("Organizations::Faq.count", -1) do
      delete faq_url(@faq)
    end

    assert_redirected_to faqs_url
  end
end
