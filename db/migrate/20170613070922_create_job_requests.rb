class CreateJobRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :job_requests do |t|
      t.integer :deal_id
      t.integer :product_id
      t.integer :color_id
      t.string :name
      t.string :sleeve
      t.string :relabeling
      t.string :woven_tag
      t.string :hang_tag
      t.string :pantone_code
      t.text :remark
      t.string :sample_required
      t.integer :budget
      t.text :client_comment

      t.timestamps
    end
  end
end
