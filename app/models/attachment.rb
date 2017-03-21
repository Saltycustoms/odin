class Attachment < ApplicationRecord
  include DesignUploader["file"]
end
