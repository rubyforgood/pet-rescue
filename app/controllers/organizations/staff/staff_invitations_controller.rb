# This controller is meant to be used in conjunction with the devise InvitationsController.
class Organizations::Staff::StaffInvitationsController < Organizations::BaseController
  layout "dashboard", only: %i[new]

  def new
    authorize! User, context: {organization: Current.organization},
      with: Organizations::StaffInvitationPolicy

    @user = User.new
  end
end
