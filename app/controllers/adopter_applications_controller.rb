class AdopterApplicationsController < ApplicationController
  before_action :authenticate_user!, :adopter_with_profile

  def index
    @applications = AdopterApplication.where(adopter_account_id:
                                             current_user.adopter_account.id)
  end
  
  # add check if application already exists
  def create
    @application = AdopterApplication.new(application_params)

    if @application.save
      redirect_to adopter_applications_path, notice: 'Application submitted.'

      # mailer
      @dog = Dog.find(params[:application][:dog_id])
      @org_staff = User.organization_staff(@dog.organization_id)
      StaffApplicationNotificationMailer.with(dog: @dog,
                                              organization_staff: @org_staff)
                                        .new_adoption_application.deliver_now
    else
      redirect_to adoptable_dog_path(params[:application][:dog_id]),
                  alert: 'Error. Please try again.'
    end
  end

  # update :status to 'withdrawn' or :profile_show to false
  def update
    @application = AdopterApplication.find(params[:id])

    if @application.update(application_params)
      redirect_to request.referrer
    else
      redirect_to profile_path, alert: 'Error.'
    end
  end

  private

  def application_params
    params.require(:application).permit(:dog_id, :adopter_account_id, :status, :profile_show)
  end
end
