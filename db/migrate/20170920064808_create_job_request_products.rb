class CreateJobRequestProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :job_request_products do |t|
      t.belongs_to :job_request, foreign_key: true
      t.integer :product_id
      t.jsonb :metadata
      
      t.timestamps
    end
  end
end
