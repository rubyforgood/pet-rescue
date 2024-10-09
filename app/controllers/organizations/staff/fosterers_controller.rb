class Organizations::Staff::FosterersController < Organizations::BaseController
  layout "dashboard"

  before_action :set_organization, only: %i[edit update]

  def index
    authorize! Person, context: {organization: Current.organization}

    @fosterer_accounts = authorized_scope(Person.fosterers)
  end

  def edit
    @fosterer = Person.find(params[:id])
  end

  def update
    @fosterer = Person.find(params[:id])

    if @fosterer.update(fosterer_params)
      flash[:success] = t(".success")
      redirect_to action: :index
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def fosterer_params
    params.require(:person)
      .permit(:first_name, :last_name, :email, :phone)
  end

  def set_organization
    @organization = Current.organization

    authorize! @organization
  end
end
