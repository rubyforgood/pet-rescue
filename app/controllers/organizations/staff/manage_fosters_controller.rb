class Organizations::Staff::ManageFostersController < Organizations::BaseController
  include ::Pagy::Backend

  layout "dashboard"

  before_action :set_foster, only: %i[destroy]

  def index
    authorize! Match, context: {organization: Current.organization}

    @q = authorized_scope(Match.fosters).ransack(params[:q])
    @pagy, paginated_fosters = pagy(
      @q.result(distinct: true).includes(:pet, :user),
      items: 10
    )
    @foster_pets = paginated_fosters.group_by(&:pet)
  end

  def destroy
    @foster.destroy

    flash[:success] = "Foster for #{@foster.pet.name} deleted."
    redirect_to action: :index
  end

  private

  def set_foster
    @foster = Match.find(params[:id])

    authorize! @foster
  end
end
