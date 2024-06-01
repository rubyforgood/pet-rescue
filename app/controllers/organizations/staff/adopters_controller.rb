class Organizations::Staff::AdoptersController < Organizations::BaseController   
  layout "dashboard"

  def index
    authorize! AdopterFosterAccount, context: {organization: Current.organization}

    @adopter_accounts = authorized_scope(AdopterFosterAccount.adopters)
  end
end