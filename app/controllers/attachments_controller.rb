class AttachmentsController < ApplicationController
  before_action :verified_staff

  def purge
    @attachment = ActiveStorage::Attachment.find(params[:id])
    @attachment.purge
    redirect_to request.referrer, notice: "Attachment removed"
  end
end
