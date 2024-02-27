class AttachmentsController < ApplicationController
  verify_authorized

  before_action :active_staff

  def purge
    @attachment = ActiveStorage::Attachment.find(params[:id])
    authorize! @attachment, with: AttachmentPolicy

    @attachment.purge
    redirect_to request.referrer, notice: "Attachment removed"
  end
end
