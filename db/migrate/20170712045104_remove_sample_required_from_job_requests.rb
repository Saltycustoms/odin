class RemoveSampleRequiredFromJobRequests < ActiveRecord::Migration[5.1]
  def change
    remove_column :job_requests, :sample_required, :string
  end
end
