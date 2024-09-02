class AdopterApplicationPolicy < ApplicationPolicy
  authorize :pet, optional: true

  pre_check :verify_form_submission!
  pre_check :verify_pet_appliable!, only: %i[create?]

  relation_scope do |relation|
    relation.where(form_submission_id: user.form_submission.id)
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
    user.id == record.form_submission.user_id
  end

  def already_applied?
    user.form_submission.adopter_applications.any? do |application|
      application.pet_id == pet.id
    end
  end

  def verify_form_submission!
    deny! unless user.form_submission.present?
  end

  def verify_pet_appliable!
    deny! if pet.application_paused
    deny! if already_applied?
  end
end
