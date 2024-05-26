class Organizations::LikePolicy < ApplicationPolicy
  authorize :pet, optional: true
  pre_check :verify_adopter_foster_account!
  pre_check :verify_pet_likable!, only: %i[create? destroy?]

  def index?
    permission?(:manage_likes)
  end

  def create?
    permission?(:manage_likes)
  end

  def destroy?
    permission?(:manage_likes)
  end

  private

  def verify_pet_likable!
    deny! if pet.organization_id != user.organization_id
  end

  def verify_adopter_foster_account!
    deny! unless user.adopter_foster_account.present?
  end
end
