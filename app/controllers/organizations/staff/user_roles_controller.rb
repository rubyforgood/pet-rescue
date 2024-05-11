class Organizations::Staff::UserRolesController < Organizations::BaseController
  before_action :context_authorize!

  def to_staff
  end

  def to_admin
  end

  private

  def context_authorize!
    authorize!
  end
end
