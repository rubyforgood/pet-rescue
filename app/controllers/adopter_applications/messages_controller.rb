class AdopterApplications::MessagesController < ApplicationController
  before_action :set_adopter_application

  def create
    message = Message.new({
      sender_id: current_user.id,
      adopter_application_id: @adopter_application.id,
      message: message_params[:message]
    })

    if message.save
      Turbo::StreamsChannel.broadcast_replace_to(
        @adopter_application,
        target: "chat",
        partial: "adopter_applications/chats/messages",
        locals: { messages: @adopter_application.messages }
      )

      render turbo_stream: [
        turbo_stream.replace('message-input', partial: 'adopter_applications/chats/message_input', locals: { match: @adopter_application }),
      ]
    else
      flash[:error] = "Something went wrong. Please try again."
      redirect_to adopter_application_chat_path(@adopter_application)
    end
  end

  private

  def message_params
    params.permit(:message)
  end

  def set_adopter_application
    @adopter_application = AdopterApplication.find(params[:adopter_application_id])
  end


end
