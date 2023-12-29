class Organizations::FormsController < Organizations::BaseController
  before_action :verified_staff
  
  layout "dashboard"
    
  def edit
    @form = Current.organization.form || Form.create(
      organization: Current.organization,
      name: "#{Current.organization.name}'s Application Form"
    )
  end
end
  