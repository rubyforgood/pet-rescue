class Organizations::AdopterFosterAdoptedPetPolicy < ApplicationPolicy
  pre_check :verify_adopter_foster_account!

  def index?
    permission?(:view_adopted_pets)
  end
end
