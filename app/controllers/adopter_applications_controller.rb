class AdopterApplicationsController < ApplicationController
  before_action :authenticate_user!, :adopter_with_profile
  before_action :check_for_existing_app, only: :create

  def create
    @application = AdopterApplication.new(application_params)

    if @application.save
      redirect_to profile_path, notice: 'Application submitted.'

      # mailer
      @dog = Dog.find(params[:dog_id])
      @organization_staff = User.organization_staff(@dog.organization_id)
      StaffApplicationNotificationMailer.with(dog: @dog, organization_staff: @organization_staff)
                                        .new_adoption_application.deliver_now
    else
      render adoptable_dog_path(params[:dog_id]),
              status: :unprocessable_entity,
              notice: 'Error. Please try again.'
    end
  end

  # update :status to 'withdrawn' or :profile_show to false
  def update
    @application = AdopterApplication.find(params[:id])

    if @application.update(application_params)
      redirect_to profile_path
    else
      redirect_to profile_path, notice: 'Error.'
    end
  end

  private

  def application_params
    params.permit(:id, :dog_id, :adopter_account_id, :status, :profile_show)
  end

  def check_for_existing_app
    if AdopterApplication.where(dog_id: params[:dog_id],
                                adopter_account_id: params[:adopter_account_id]).exists?

      redirect_to adoptable_dog_path(params[:dog_id]),
                  notice: 'Application already exists.'
    end
  end
end
