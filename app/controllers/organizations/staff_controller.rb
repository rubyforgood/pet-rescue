class Organizations::StaffController < Organizations::BaseController
  before_action :require_organization_admin
  layout "dashboard"

  def index
    @staff_accounts = StaffAccount.all
  end

  def deactivate
    staff_account = StaffAccount.find(params[:staff_id])
    if staff_account.user != current_user
      staff_account.deactivate
      redirect_to staff_index_path, notice: "Staff account deactivated."
    else
      redirect_to staff_index_path, alert: "You can't deactivate yourself."
    end
  end

  def activate
    staff_account = StaffAccount.where(organization: current_tenant).find(params[:staff_id])
    staff_account.activate
    redirect_to staff_index_path, notice: "Staff account activated."
  end
end
