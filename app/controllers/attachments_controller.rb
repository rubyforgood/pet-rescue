class AttachmentsController < ApplicationController
  before_action :verified_staff

  def purge
    @attachment = ActiveStorage::Attachment.find(params[:id])
    @attachment.purge
    redirect_to request.referrer, notice: "Attachment removed"
  end

  def download
    @attachment = ActiveStorage::Attachment.find(params[:id])
    file_path = @attachment.blob.service.send(:path_for, @attachment.blob[:key])
    send_file file_path, filename: @attachment.blob[:filename], disposition: 'attachment'
  end
end
