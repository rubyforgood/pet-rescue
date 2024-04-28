class Organizations::PublicFaqController < Organizations::BaseController
  skip_verify_authorized only: %i[index]

  def index
    @faqs = Faq.all
  end
end
