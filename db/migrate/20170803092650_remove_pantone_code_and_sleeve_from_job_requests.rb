class RemovePantoneCodeAndSleeveFromJobRequests < ActiveRecord::Migration[5.1]
  def change
    remove_column :job_requests, :sleeve, :string
    remove_column :job_requests, :pantone_code, :string
  end
end
