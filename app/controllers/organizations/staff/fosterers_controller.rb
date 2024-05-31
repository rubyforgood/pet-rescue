class Organizations::Staff::FosterersController < Organizations::BaseController
  skip_before_action :authenticate_user!
  layout "dashboard"

  def index
    authorize! AdopterFosterAccount, context: {organization: Current.organization}

    @fosterer_accounts = authorized_scope(AdopterFosterAccount.fosterers)
  end
end
