class RemoveColorIdFromJobRequests < ActiveRecord::Migration[5.1]
  def change
    remove_column :job_requests, :color_id, :integer
  end
end
