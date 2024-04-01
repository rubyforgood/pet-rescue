class Organizations::PageTextPolicy < ApplicationPolicy
  pre_check :verify_organization!
  pre_check :verify_active_staff!

  def manage?
    permission?(:manage_page_text)
  end
end
