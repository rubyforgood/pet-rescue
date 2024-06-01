class Organizations::Staff::FosterersController < Organizations::BaseController
  layout "dashboard"
  before_action :set_fosterer, only: %i[update_activation]

  def index
    authorize! AdopterFosterAccount, context: {organization: Current.organization}

    @fosterer_accounts = authorized_scope(AdopterFosterAccount.fosterers)
  end

  def deactivate
    @fosterer_account.deactivate
    respond_to do |format|
      format.html { redirect_to staff_fosterers_index_path, notice: "Fosterer account deactivated." }
      format.turbo_stream { render "organizations/staff/fosterers/update" }
    end
  end

  def activate
    @fosterer_account.activate
    respond_to do |format|
      format.html { redirect_to staff_fosterers_index_path, notice: "Fosterer account activated." }
      format.turbo_stream { render "organizations/staff/fosterers/update" }
    end
  end

  def update_activation
    if @fosterer_account.deactivated_at
      activate
    else
      deactivate
    end
  end

  private

  def set_fosterer
    @fosterer_account = AdopterFosterAccount.find(params[:fosterer_id])

    authorize! @fosterer_account
  end
end
