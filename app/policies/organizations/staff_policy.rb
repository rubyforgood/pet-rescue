class Organizations::StaffPolicy < ApplicationPolicy
  def deactivate?
  pre_check :verify_organization!, except: %i[index?]
    permission?(:manage_staff)
  end

  def activate?
    permission?(:manage_staff)
  end

  def update_activation?
    permission?(:manage_staff)
  end

  def index?
    permission?(:manage_staff)
  end
end
