class AddProvideArtworkToJobRequests < ActiveRecord::Migration[5.1]
  def change
    add_column :job_requests, :provide_artwork, :boolean, default: false
  end
end
