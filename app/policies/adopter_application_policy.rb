class AdopterApplicationPolicy < ApplicationPolicy
  authorize :pet, optional: true

  pre_check :verify_adopter_profile!, only: %i[index? create?]
  pre_check :verify_pet_adoptable!, only: %i[create?]

  def update?
    applicant? && permission?(:withdraw_adopter_applications)
  end

  def index?
    permission?(:view_adopter_applications)
  end

  def create?
    permission?(:create_adopter_applications)
  end

  private

  def applicant?
    user.id == record.adopter_account.user_id
  end

  def verify_adopter_profile!
    deny! unless user.adopter_account.present?
    deny! unless user.adopter_account.adopter_profile.present?
  end

  def verify_pet_adoptable!
    deny! if pet.application_paused
  end
end
