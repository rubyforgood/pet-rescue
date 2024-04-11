class Organizations::HomeController < Organizations::BaseController
  skip_verify_authorized only: %i[index]

  SAMPLE_SIZE = 4

  def index
    @pets = Pet.includes(images_attachments: :blob).where(organization: Current.organization).sample(SAMPLE_SIZE)
  end
end
