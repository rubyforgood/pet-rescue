class AdoptablePetPolicy < ApplicationPolicy
  skip_pre_check :verify_authenticated!, only: %i[show?]

  def show?
    permission?(:manage_pets) || published?
  end

  private

  def published?
    record.published?
  end
end
