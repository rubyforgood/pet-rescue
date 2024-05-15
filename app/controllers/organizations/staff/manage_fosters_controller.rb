class Organizations::Staff::ManageFostersController < Organizations::BaseController
  layout "dashboard"

  def index
    authorize! User, context: {organization: Current.organization},
      with: Organizations::ManageFostersPolicy
  end
end
