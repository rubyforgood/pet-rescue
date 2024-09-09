class Organizations::Staff::AdoptersController < Organizations::BaseController
  layout "dashboard"

  def index
    authorize! Person, context: {organization: Current.organization}

    @adopter_accounts = authorized_scope(Person.adopters)
  end
end
