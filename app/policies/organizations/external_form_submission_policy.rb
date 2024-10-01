class Organizations::ExternalFormSubmissionPolicy < ApplicationPolicy
  def index?
    permission?(:manage_forms)
  end
end
