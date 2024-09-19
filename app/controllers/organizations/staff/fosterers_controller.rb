class Organizations::Staff::FosterersController < Organizations::BaseController
  layout "dashboard"

  def index
    authorize! Person, context: {organization: Current.organization}

    @fosterer_accounts = authorized_scope(Person.fosterers)
  end
end
