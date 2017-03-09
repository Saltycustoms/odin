class CreateShippingZoneLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :shipping_zone_locations do |t|
      t.string :country_code
      t.string :state
      t.integer :shipping_zone_id

      t.timestamps
    end
  end
end
