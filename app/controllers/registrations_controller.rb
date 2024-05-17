class RegistrationsController < Devise::RegistrationsController
  include OrganizationScopable
  layout :set_layout, only: [:edit, :update, :new]

  after_action :send_email, only: :create

  # nested form in User>registration>new for an adopter or staff account
  # no attributes need to be accepted, just create new account with user_id reference
  def new
    build_resource({})
    resource.build_adopter_foster_account
    respond_with resource
  end

  def create
    super do |resource|
      if resource.persisted?
        resource.add_role(:adopter, Current.organization)
      end
    end
  end

  private

  def set_layout
    if current_user&.staff_account
      'dashboard'
    elsif current_user&.adopter_foster_account
      'adopter_foster_dashboard'
    else
      'application'
    end
  end

  def sign_up_params
    params.require(:user).permit(:username,
      :first_name,
      :last_name,
      :email,
      :password,
      :signup_role,
      :tos_agreement,
      adopter_foster_account_attributes: [:user_id])
  end

  def account_update_params
    params.require(:user).permit(:username,
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation,
      :signup_role,
      :current_password,
      :avatar)
  end

  def after_sign_up_path_for(resource)
    current_user&.adopter_foster_account ? adopter_fosterer_dashboard_index_path : root_path
  end

  # check for id (i.e., record saved) and send mail
  def send_email
    return unless resource.id

    SignUpMailer.with(user: resource).adopter_welcome_email(current_tenant.slug).deliver_now
  end
end

# see here for setting up redirects after login for each user type
# https://stackoverflow.com/questions/58296569/how-to-signup-in-two-different-pages-with-devise
