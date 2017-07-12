class AddSampleRequiredToJobRequests < ActiveRecord::Migration[5.1]
  def change
    add_column :job_requests, :sample_required, :boolean, default: false
  end
end
