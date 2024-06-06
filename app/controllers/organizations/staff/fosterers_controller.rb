class Organizations::Staff::FosterersController < Organizations::BaseController
  layout "dashboard"

  def index
    authorize! AdopterFosterAccount, context: {organization: Current.organization}

    @fosterer_accounts = authorized_scope(AdopterFosterAccount.fosterers)
  end
end
