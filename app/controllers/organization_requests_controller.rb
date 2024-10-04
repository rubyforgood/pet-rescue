class OrganizationRequestsController < ApplicationController
  skip_before_action :authenticate_user!
  skip_verify_authorized only: %i[new create]

  def new
    @organization_request = OrganizationRequest.new
  end

  def create
    @organization_request = OrganizationRequest.new(organization_params)

    if @organization_request.valid?
      OrganizationMailer.with(organization_params).send_organization_request.deliver_later
      redirect_to root_path, notice: "Organization request submitted successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def organization_params
    params.require(:organization_request).permit(:org_name, :name, :phone, :email, :country, :city, :state)
  end
end
