class Organizations::Staff::UserRolesController < Organizations::BaseController
  before_action :set_user

  def to_staff
    ActiveRecord::Base.transaction do
      change_role(@user, :admin, :staff)
    end
  end

  def to_admin
    ActiveRecord::Base.transaction do
      change_role(@user, :staff, :admin)
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
    authorize! @user, with: Organizations::UserRolesPolicy, to: :change_role?,
      context: {organization: Current.organization}
  end

  def change_role(user, from_role, to_role)
    user.add_role(to_role, Current.organization)
    user.remove_role(from_role, Current.organization)

    if user.only_has_role?(to_role, Current.organization)
      respond_to do |format|
        format.html { redirect_to request.referrer, notice: "Account changed to #{to_role}" }
        format.turbo_stream { flash.now[:notice] = "Account changed to #{to_role}" }
      end
    else
      respond_to do |format|
        format.html { redirect_to request.referrer, alert: "Error changing role" }
        format.turbo_stream { flash.now[:alert] = "Error changing role" }
      end
      raise ActiveRecord::Rollback
    end
  end
end
