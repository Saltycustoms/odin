class CreatePrintDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :print_details do |t|
      t.integer :job_request_id
      t.string :position
      t.string :block
      t.string :color_count
      t.string :print_method
      t.text :attachment_data

      t.timestamps
    end
  end
end
