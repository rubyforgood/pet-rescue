class Organizations::Staff::ManageFostersController < Organizations::BaseController
  layout "dashboard"

  def index
    authorize! User, context: {organization: Current.organization},
      with: Organizations::ManageFostersPolicy

    @q = authorized_scope(Match.fosters).ransack(params[:q])
    @foster_pets = @q.result(distinct: true).includes(:pet).group_by(&:pet)
  end
end
