class Organizations::HomeController < Organizations::BaseController
  verify_authorized

  skip_verify_authorized only: %i[index]

  def index
  end
end
