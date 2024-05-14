class Organizations::Staff::UserRolesController < Organizations::BaseController
  before_action :set_user

  def to_staff
    change_role(@user, :admin, :staff)
  end

  def to_admin
    change_role(@user, :staff, :admin)
  end

  private

  def set_user
    @user = User.find(params[:id])
    authorize! @user, with: Organizations::UserRolesPolicy, to: :change_role?,
      context: {organization: Current.organization}
  end

  def change_role(user, previous, new)
    ActiveRecord::Base.transaction do
      user.remove_role(previous, user.organization)
      user.add_role(new, user.organization)
      respond_to do |format|
        format.html { redirect_to request.referrer, notice: "Account changed to #{new.capitalize}" }
        format.turbo_stream { flash.now[:notice] = "Account changed to #{new.capitalize}" }
      end
    end
  rescue
    respond_to do |format|
      format.html { redirect_to request.referrer, alert: "Error changing role" }
      format.turbo_stream { flash.now[:alert] = "Error changing role" }
    end
  end
end
