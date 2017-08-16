class RemoveJobRequestFromAttachments < ActiveRecord::Migration[5.1]
  def change
    remove_reference :attachments, :job_request
  end
end
