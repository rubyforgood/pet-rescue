class Organizations::FosterersController < Organizations::BaseController
  skip_verify_authorized

  layout "dashboard"

  def index
    @fosterer_accounts = AdopterFosterAccount.fosterers
    # authorize! AdopterFosterAccount, context: {organization: Current.organization}

    # @fosterer_accounts = authorized_scope(AdopterFosterAccount.all)
  end
end
