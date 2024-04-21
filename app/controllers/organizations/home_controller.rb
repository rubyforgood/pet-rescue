class Organizations::HomeController < Organizations::BaseController
  skip_verify_authorized only: %i[index]

  def index
    @pets = Pet.includes(images_attachments: :blob)
               .where(organization: Current.organization)
               .sample(4)
  end
end
