class CreateShippingZones < ActiveRecord::Migration[5.0]
  def change
    create_table :shipping_zones do |t|
      t.string :name
      t.boolean :disabled

      t.timestamps
    end
  end
end
