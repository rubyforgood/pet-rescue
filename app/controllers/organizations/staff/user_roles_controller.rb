class Organizations::Staff::UserRolesController < Organizations::BaseController
  before_action :context_authorize!
  before_action :set_user

  def to_staff
    @user.add_role :staff
    @user.remove_role :admin
    respond_to do |format|
      format.html { redirect_to request.referrer, notice: "Account changed to Staff" }
      format.turbo_stream { flash.now[:notice] = "Account changed to Staff" }
    end
  end

  def to_admin
    @user.add_role :admin
    @user.remove_role :staff
    respond_to do |format|
      format.html { redirect_to request.referrer, notice: "Account changed to Admin" }
      format.turbo_stream { flash.now[:notice] = "Account changed to Admin" }
    end
  end

  private

  def context_authorize!
    authorize! with: Organizations::UserRolesPolicy, context: {organization: Current.organization}
  end

  def set_user
    @user = User.find(params[:id])
    return unless current_user.id == @user.id

    redirect_to request.referrer, alert: "You cannot change your own role."
  end
end
