class AdopterApplicationPolicy < ApplicationPolicy
  authorize :pet, optional: true

  pre_check :verify_profile!
  pre_check :verify_pet_appliable!, only: %i[create?]

  relation_scope do |relation|
    relation.where(adopter_foster_account_id: user.adopter_foster_account.id)
  end

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
    user.id == record.adopter_foster_account.user_id
  end

  def already_applied?
    user.adopter_foster_account.adopter_applications.any? do |application|
      application.pet_id == pet.id
    end
  end

  def verify_profile!
    deny! unless user.adopter_account.present?
    deny! unless user.adopter_account.adopter_foster_profile.present?
  end

  def verify_pet_appliable!
    deny! if pet.application_paused
    deny! if already_applied?
  end
end
