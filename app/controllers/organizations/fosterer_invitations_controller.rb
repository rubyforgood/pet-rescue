# This controller is meant to be used in conjunction with the devise InvitationsController.
class Organizations::FostererInvitationsController < Organizations::BaseController
  layout "dashboard", only: %i[new]

  def new
    authorize! User, context: {organization: Current.organization},
      with: Organizations::FostererInvitationPolicy

    @user = User.new
  end
end
