class Organizations::InvitationsController < Devise::InvitationsController
  verify_authorized

  include OrganizationScopable

  layout "dashboard", only: [:new, :create]

  def new
    authorize! StaffAccount, context: {organization: Current.organization},
      with: Organizations::InvitationPolicy

    @user = User.new
    @staff = StaffAccount.new(user: @user)
  end

  def create
    @user = User.new(user_params.merge(password: SecureRandom.hex(8)).except(:roles))
    @user.staff_account = StaffAccount.new

    authorize! StaffAccount, context: {organization: @user.organization},
      with: Organizations::InvitationPolicy

    if @user.save
      @user.add_role(user_params[:roles], Current.organization)
      @user.invite!(current_user)
      redirect_to staff_index_path, notice: "Invite sent!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user)
      .permit(:first_name, :last_name, :email, :roles)
  end

  def after_accept_path_for(_resource)
    dashboard_index_path
  end
end
