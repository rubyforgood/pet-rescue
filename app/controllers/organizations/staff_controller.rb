class Organizations::StaffController < Organizations::BaseController
  before_action :require_organization_admin
  layout "dashboard"

  def index
    @staff_accounts = StaffAccount.all
  end

  def new
    @staff = StaffAccount.new(user: User.new)
  end

  def create
    @user = User.new(staff_params[:user].merge(password: SecureRandom.hex(8)))
    @staff = StaffAccount.new(user: @user, verified: true)

    if @user.save && @staff.save
      @staff.add_role(staff_params[:role])
      redirect_to staff_index_path, notice: "Staff saved successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def staff_params
    params.require(:staff_account)
      .permit(:role, user: [:first_name, :last_name, :email])
  end
end
