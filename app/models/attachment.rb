class Attachment < ApplicationRecord
  belongs_to :attachable, polymorphic: true, optional: true
  include AttachmentUploader::Attachment.new(:attachment)
end
