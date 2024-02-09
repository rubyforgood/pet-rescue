class Organizations::PetPolicy < ApplicationPolicy
  pre_check :verify_organization!
  pre_check :verify_active_staff!

  alias_rule :index?, :create?, :new?, :attach_files?, :attach_images?,
    to: :manage?

  def manage?
    permission?(:manage_pets)
  end

  private

  def verify_active_staff!
    deny! unless user.staff_account
    deny! if user.staff_account.deactivated?
  end
end
