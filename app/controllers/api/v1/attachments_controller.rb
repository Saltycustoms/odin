class Api::V1::AttachmentsController < ApiController
  def create
    @attachment = Attachment.create(file: params[:file])
    hash = {}
    if @attachment
      hash[:id] = @attachment.id
      hash[:preview] = @attachment.file[:original].url
      hash[:image] = {}
      hash[:image][:original_url] = @attachment.file[:original].url
      hash[:image][:small_url] = @attachment.file[:small].url
      hash[:image][:large_url] = @attachment.file[:large].url
    else
      hash[:errors] = @attachment.errors
    end
    render json: hash
  end
end
