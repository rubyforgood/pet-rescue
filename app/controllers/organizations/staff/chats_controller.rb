class Organizations::Staff::ChatsController < Organizations::BaseController
  layout "dashboard"

  def index
    @user = current_user
    @organization = Current.organization

    authorize! :chat, context: {organization: @organization}

    chats = Chat.order(initiated_on: :desc).includes(:initiated_by, :messages, chat_pets: [:pet], participants: [:user])
    chats = chats.where(chat_pets: {pet: params[:pets]}) if params[:pets].present?

    @chats_by_date = authorized_scope(chats)
      .group_by(&:initiated_on)

    @pet_names = authorized_scope(Pet.order(:name)).pluck(:name, :id)
  end

  def create
    chat = Chat.build(create_params)
    authorize! chat, context: {organization: @organization}

    chat.save!

    redirect_to staff_chats_path
  end

  private

  def create_params
    {
      initiated_by: current_user,
      initiated_on: Date.today
    }
  end
end
