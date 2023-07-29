class AdopterApplications::ChatsController < ApplicationController
  def show
    @match = AdopterApplication.find(params[:adopter_application_id])
    @messages = @match.messages.includes(:sender)
  end
end
