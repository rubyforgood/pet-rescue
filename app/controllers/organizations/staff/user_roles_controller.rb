class Organizations::Staff::UserRolesController < Organizations::BaseController
  before_action :set_user
  before_action :context_authorize!

  def to_staff
    @user.transaction do
      @user.add_role :staff, Current.organization
      @user.remove_role :admin, Current.organization
      respond_to do |format|
        format.html { redirect_to request.referrer, notice: "Account changed to Staff" }
        format.turbo_stream { flash.now[:notice] = "Account changed to Staff" }
      end
    end
  rescue => e
    respond_to do |format|
      format.html { redirect_to request.referrer, notice: e }
      format.turbo_stream { flash.now[:notice] = e }
    end
  end

  def to_admin
    @user.transaction do
      @user.add_role :admin, Current.organization
      @user.remove_role :staff, Current.organization
      respond_to do |format|
        format.html { redirect_to request.referrer, notice: "Account changed to Admin" }
        format.turbo_stream { flash.now[:notice] = "Account changed to Admin" }
      end
    end
  rescue => e
    respond_to do |format|
      format.html { redirect_to request.referrer, notice: e }
      format.turbo_stream { flash.now[:notice] = e }
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def context_authorize!
    authorize! @user, with: Organizations::UserRolesPolicy
  end
end
