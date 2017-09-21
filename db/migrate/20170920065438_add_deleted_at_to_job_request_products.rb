class AddDeletedAtToJobRequestProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :job_request_products, :deleted_at, :datetime
    add_index :job_request_products, :deleted_at
  end
end
