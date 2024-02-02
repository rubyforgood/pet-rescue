class AdoptablePetPolicy < ApplicationPolicy
  authorize :user, allow_nil: true

  def show?
    permission?(:manage_pets) || published?
  end

  private

  def published?
    record.published?
  end
end
