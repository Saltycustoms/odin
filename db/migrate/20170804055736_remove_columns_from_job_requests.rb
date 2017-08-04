class RemoveColumnsFromJobRequests < ActiveRecord::Migration[5.1]
  def change
    remove_column :job_requests, :relabeling, :string
    remove_column :job_requests, :woven_tag, :string
    remove_column :job_requests, :hang_tag, :string
    remove_column :job_requests, :sample_required, :boolean
  end
end
