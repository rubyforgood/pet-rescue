class Organizations::Staff::ExternalFormSubmissionController < Organizations::BaseController
  layout "dashboard"
  def index
    authorize! StaffAccount, context: {organization: Current.organization}
  end
end
