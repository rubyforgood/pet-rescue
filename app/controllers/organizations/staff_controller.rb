class Organizations::StaffController < Organizations::BaseController
  before_action :require_organization_admin
  layout "dashboard"

  def index
    @staff_accounts = StaffAccount.all
  end

  def new
    @user = User.new
    @staff = StaffAccount.new(user: @user)
  end

  def create
    @user = User.new(user_params.merge(password: SecureRandom.hex(8)).except(:staff_account_attributes))
    @user.staff_account = StaffAccount.new

    if @user.save
      @user.staff_account.add_role(user_params[:staff_account_attributes][:roles])
      redirect_to staff_index_path, notice: "Staff saved successfully."
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
