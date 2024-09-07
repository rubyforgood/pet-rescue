module Organizations
  class FormSubmissionService
    def initialize(user)
      @user = user
    end

    attr_reader :user

    def create
      FormSubmission.create!(person_id: user.person_id, organization_id: user.organization_id)
    end
  end
end