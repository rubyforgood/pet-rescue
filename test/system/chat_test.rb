require "test_helper"
require "application_system_test_case"

class ChatTest < ApplicationSystemTestCase
  setup do
    @admin = create(:staff)
    sign_in @admin

    @pet = create(:pet)
    @foster = create(:user)
  end

  context "initiating a new chat" do
    should "creates a new chat" do
      visit staff_chats_path

      click_on "Initiate Chat"
      assert_text Date.today.to_s

      within("article.chat", match: :first) do
        assert_text @admin.full_name
      end
    end
  end
end
