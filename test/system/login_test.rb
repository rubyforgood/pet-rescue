require "application_system_test_case"

class LoginTest < ApplicationSystemTestCase
  setup do
    ActsAsTenant.with_mutable_tenant do
      @user = create(:user, :verified_staff)
    end
  end

  context "when logging in as a staff member" do
    should "direct to the organization's adoptable pets page" do
      visit root_url
      click_on "Log In"

      fill_in "Email", with: @user.email
      fill_in "Password", with: @user.password
      click_on "Log in"

      assert current_path.include?(@user.organization.slug)
      assert page.has_content?("Signed in successfully.")
    end
  end
end
