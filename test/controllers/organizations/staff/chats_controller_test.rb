require "test_helper"

class Organizations::Staff::ChatsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get organizations_staff_chats_index_url
    assert_response :success
  end
end
