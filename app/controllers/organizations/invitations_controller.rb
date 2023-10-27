class Organizations::InvitationsController < Devise::InvitationsController
  include OrganizationScopable
  # TODO: remove next line once we fix links in the invitation emails
  skip_before_action :set_tenant, except: [:new, :create]
  before_action :require_organization_admin, only: [:new, :create]
  layout "dashboard", only: [:new, :create]

  def new
    @user = User.new
    @staff = StaffAccount.new(user: @user)
  end

  def create
    @user = User.new(user_params.merge(password: SecureRandom.hex(8)).except(:staff_account_attributes))
    @user.staff_account = StaffAccount.new(verified: true)

    if @user.save
      @user.staff_account.add_role(user_params[:staff_account_attributes][:roles])
      @user.invite!(current_user)
      redirect_to staff_index_path, notice: "Invite sent!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user)
      .permit(:first_name, :last_name, :email,
        staff_account_attributes: [:roles])
  end
end
