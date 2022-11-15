class AttachmentsController < ApplicationController

  def purge
    @attachment = ActiveStorage::Attachment.find(params[:id])
    @attachment.purge
    redirect_to request.referrer, notice: "Attachment removed"
  end
end