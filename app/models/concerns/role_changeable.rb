# Module to change User roles using Rolify methods
module RoleChangeable
  extend ActiveSupport::Concern

  def change_role(user, previous = nil, new = nil)
    ActiveRecord::Base.transaction do
      user.remove_role(previous, user.organization) if previous
      user.add_role(new, user.organization) if new
    end
  rescue
    false
  end
end
