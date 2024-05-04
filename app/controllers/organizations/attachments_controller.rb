class Organizations::AttachmentsController < ApplicationController
  def purge
    @attachment = ActiveStorage::Attachment.find(params[:id])
    authorize! @attachment

    @attachment.purge
    redirect_to request.referrer, notice: 'Attachment removed'
  end

  def purge_avatar
    @attachment = ActiveStorage::Attachment.find(params[:id])
    authorize! @attachment

    if current_user.avatar.id == @attachment.id
      @attachment.purge
      redirect_to request.referrer, notice: 'Avatar removed'
    else
      redirect_to request.referrer, alert: "You can't delete this attachment"
    end
  end
end
