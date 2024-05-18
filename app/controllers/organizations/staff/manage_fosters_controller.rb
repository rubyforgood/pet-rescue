class Organizations::Staff::ManageFostersController < Organizations::BaseController
  include ::Pagy::Backend

  layout "dashboard"

  def index
    authorize! Match, context: {organization: Current.organization}

    @q = authorized_scope(Match.fosters).ransack(params[:q])
    @pagy, @paginated_foster_pets = pagy(
      @q.result(distinct: true).includes(:pet, :user),
      items: 10
    )
    @foster_pets = @paginated_foster_pets.group_by(&:pet)
  end
end
