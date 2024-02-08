class Organizations::PetPolicy < ApplicationPolicy
  pre_check :verify_organization!, except: %i[]
  pre_check :verify_active_staff!

  def manage?
    permission?(:manage_pets)
  end

  private

  def verify_active_staff!
    deny! unless user.staff_account
    deny! if user.staff_account.deactivated?
  end
end
