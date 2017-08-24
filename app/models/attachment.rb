class Attachment < ApplicationRecord
  acts_as_paranoid
  belongs_to :attachable, polymorphic: true, optional: true
  include AttachmentUploader::Attachment.new(:attachment)

  def attachment_full_url
    "#{Figaro.env.locate_deal_app}#{attachment_url}"
  end

  def attachment_original_filename
    attachment.original_filename
  end

  def as_json(*)
    previous = super
    previous[:attachment_full_url] = attachment_full_url
    previous[:attachment] = attachment
    previous[:attachment_original_filename] = attachment_original_filename
    previous
  end
end
