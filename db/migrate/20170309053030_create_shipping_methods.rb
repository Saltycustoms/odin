class CreateShippingMethods < ActiveRecord::Migration[5.0]
  def change
    create_table :shipping_methods do |t|
      t.string :type
      t.integer :shipping_zone_id
      t.integer :calculator_id
      t.string :name
      t.jsonb :properties

      t.timestamps
    end
  end
end
