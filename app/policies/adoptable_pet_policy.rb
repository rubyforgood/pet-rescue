class AdoptablePetPolicy < ApplicationPolicy
  authorize :user, allow_nil: true

  def show?
    staff? || published?
    # permission?(:manage_pets) || published?
  end

  private

  def published?
    record.published?
  end

  def staff?
    user&.staff_account.present?
  end

  def adopter?
    user&.adopter_account.present?
  end
end
