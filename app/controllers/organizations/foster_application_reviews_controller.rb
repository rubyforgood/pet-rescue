class Organizations::FosterApplicationReviewsController < Organizations::BaseController
  verify_authorized

  layout "dashboard"

  def index
  end
end
