class CreateDesigns < ActiveRecord::Migration[5.0]
  def change
    create_table :designs do |t|
      t.integer :order_id
      t.integer :order_line_id
      t.jsonb :properties

      t.timestamps
    end
  end
end
