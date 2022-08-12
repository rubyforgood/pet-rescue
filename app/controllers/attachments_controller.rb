class AttachmentsController < ApplicationController

  def purge
    @attachment = ActiveStorage::Attachment.find(params[:id])
    @attachment.purge
    redirect_back fallback_location: dogs_path, notice: "Attachment removed"
  end
end