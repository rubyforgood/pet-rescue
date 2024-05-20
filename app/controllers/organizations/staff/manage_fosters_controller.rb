class Organizations::Staff::ManageFostersController < Organizations::BaseController
  include ::Pagy::Backend

  layout "dashboard"

  before_action :context_authorize, only: %i[new create index]
  before_action :set_foster, only: %i[edit update destroy]

  def new
    @pets = Pet.fosterable.order(:name)
    @accounts = AdopterFosterAccount.fosterers.order(:last_name)
    @foster = Match.new
  end

  def create
    @foster = Match.new(match_params.merge(match_type: :foster))

    if @foster.save
      redirect_to action: :index
    else
      @pets = Pet.fosterable.order(:name)
      @accounts = AdopterFosterAccount.fosterers.order(:last_name)

      render :new, status: :unprocessable_entity
    end
  end

  def index
    @q = authorized_scope(Match.fosters).ransack(params[:q])
    @pagy, paginated_fosters = pagy(
      @q.result(distinct: true)
        .includes(:pet, :user)
        .order("pet.updated_at DESC"),
      items: 10
    )
    @foster_pets = paginated_fosters.group_by(&:pet)
  end

  def edit
  end

  def update
    if @foster.update(match_params)
      redirect_to action: :index
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @foster.destroy

    flash[:success] = "Foster for #{@foster.pet.name} deleted."
    redirect_to action: :index
  end

  private

  def match_params
    params.require(:match).permit(
      :pet_id,
      :adopter_foster_account_id,
      :start_date,
      :end_date
    )
  end

  def context_authorize
    authorize! Match, context: {organization: Current.organization}
  end

  def set_foster
    @foster = Match.find(params[:id])

    authorize! @foster
  end
end
