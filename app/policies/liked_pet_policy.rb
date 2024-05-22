class LikedPetPolicy < ApplicationPolicy
  authorize :pet, optional: true

  def create?
    permission?(:manage_liked_pets)
  end

  def destroy?
    permission?(:manage_liked_pets)
  end
end
