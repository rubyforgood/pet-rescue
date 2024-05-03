class Organizations::InvitationsController < Devise::InvitationsController
  include OrganizationScopable

  layout "dashboard", only: [:new, :create]

  # Do not use this action! Use other invitation controllers instead for new.
  def new
    authorize! User, context: {organization: Current.organization},
      with: Organizations::InvitationPolicy

    @user = User.new
  end

  def create
    case user_params[:roles]
    when "admin", "staff"
      authorize! User, context: {organization: Current.organization},
        with: Organizations::StaffInvitationPolicy

      @user = User.new(
        user_params.merge(password: SecureRandom.hex(8)).except(:roles)
      )
      @user.add_role(user_params[:roles], Current.organization)
      @user.build_staff_account

      if @user.save
        @user.invite!(current_user)
        redirect_to staff_index_path, notice: "Invite sent!"
      else
        render :new, status: :unprocessable_entity
      end
    when "fosterer"
      authorize! User, context: {organization: Current.organization},
        with: Organizations::FostererInvitationPolicy

      @user = User.new(
        user_params.merge(password: SecureRandom.hex(8)).except(:roles)
      )
      @user.add_role("adopter", Current.organization)
      @user.add_role("fosterer", Current.organization)
      @user.build_adopter_foster_account

      if @user.save
        @user.invite!(current_user)
        redirect_to fosterers_path, notice: "Invite sent!"
      else
        render :new, status: :unprocessable_entity
      end
    else
      :deny
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
