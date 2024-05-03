class Organizations::FostererInvitationsController < Organizations::BaseController
  layout "dashboard", only: %i[new]

  def new
    authorize! User, context: {organization: Current.organization},
      with: Organizations::FostererInvitationPolicy

    @user = User.new
  end
end
