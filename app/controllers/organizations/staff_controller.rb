class Organizations::StaffController < Organizations::BaseController
  before_action :require_organization_admin
  before_action :set_staff_account, only: [:update_activation, :deactivate, :activate]
  layout "dashboard"

  def index
    @staff_accounts = StaffAccount.all
  end

  def deactivate
    if @staff_account.user != current_user
      @staff_account.deactivate
      respond_to do |format|
        format.html { redirect_to staff_index_path, notice: "Staff account deactivated." }
        format.turbo_stream { render "organizations/staff/update" } 
      end
    else
      redirect_to staff_index_path, alert: "You can't deactivate yourself."
    end
  end

  def activate
    @staff_account.activate
    respond_to do |format|
      format.html { redirect_to staff_index_path, notice: "Staff account activated." }
      format.turbo_stream { render "organizations/staff/update" } 
    end
  end

  def update_activation
    if @staff_account.deactivated_at
      activate
    else
      deactivate
    end
  end

  private 

  def set_staff_account
    @staff_account = StaffAccount.where(organization: current_tenant).find(params[:staff_id])
  end
end
