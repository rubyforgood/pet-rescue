class Organizations::Staff::ExternalFormSubmissionController < Organizations::BaseController
  layout "dashboard"
  def index
    authorize! Person, context: {organization: Current.organization}
  end
end
