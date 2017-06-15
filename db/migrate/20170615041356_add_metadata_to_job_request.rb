class AddMetadataToJobRequest < ActiveRecord::Migration[5.1]
  def change
    add_column :job_requests, :metadata, :jsonb
  end
end
