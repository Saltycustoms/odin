class AddUniqueIndexToProperties < ActiveRecord::Migration[5.1]
  def change
    add_index :properties, [ :job_request_id, :name ], :unique => true
  end
end
