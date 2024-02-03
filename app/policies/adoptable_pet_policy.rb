class AdoptablePetPolicy < ApplicationPolicy
  def show?
    permission?(:manage_pets) || published?
  end

  private

  def published?
    record.published?
  end
end
