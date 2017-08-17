class Attachment < ApplicationRecord
  belongs_to :attachable, polymorphic: true, optional: true
  include AttachmentUploader::Attachment.new(:attachment)

  def attachment_full_url
    "#{Figaro.env.locate_deal_app}#{attachment_url}"
  end

  def attachment_original_filename
    attachment.original_filename
  end
end
