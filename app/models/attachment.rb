class Attachment < ApplicationRecord
  belongs_to :job_request
  include AttachmentUploader::Attachment.new(:attachment)
end
