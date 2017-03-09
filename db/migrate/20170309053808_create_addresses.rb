class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.integer :user_id
      t.string :att
      t.string :line1
      t.string :line2
      t.string :state
      t.string :post_code
      t.string :country_code
      t.string :city
      t.string :tel

      t.timestamps
    end
  end
end
