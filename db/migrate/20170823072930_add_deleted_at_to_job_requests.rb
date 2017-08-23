class AddDeletedAtToJobRequests < ActiveRecord::Migration[5.1]
  def change
    add_column :job_requests, :deleted_at, :datetime
    add_index :job_requests, :deleted_at
  end
end
