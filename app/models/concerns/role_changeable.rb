# Module to change User roles using Rolify methods
module RoleChangeable
  extend ActiveSupport::Concern

  def change_role(previous, new)
    ActiveRecord::Base.transaction do
      remove_role(previous, organization)
      add_role(new, organization)
    end
  rescue
    false
  end
end
