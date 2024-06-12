module Organizations
  class SubmissionPolicy < ApplicationPolicy
    pre_check :verify_organization!
    pre_check :verify_active_staff!

    alias_rule :index?, to: :manage?

    def manage?
      permission?(:review_adopter_applications)
    end

    private

    def organization
      @organization || record.pet.organization
    end
  end
end