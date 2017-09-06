class ChangePropertyToJobRequestProperties < ActiveRecord::Migration[5.1]
  def change
    rename_table :properties, :job_request_properties
  end
end
