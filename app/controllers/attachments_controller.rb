class AttachmentsController < ApplicationController
  def download
    @attachment = Attachment.find(params[:id])
    send_file @attachment.attachment.download, filename: @attachment.attachment.original_filename
  end
end
