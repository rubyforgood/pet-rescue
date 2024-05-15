module RoleChangeable
  extend ActiveSupport::Concern

  def change_role(user, previous = nil, new = nil)
    ActiveRecord::Base.transaction do
      user.remove_role(previous, user.organization) unless !previous
      user.add_role(new, user.organization) unless !new
    end
  rescue
    false
  end
end
