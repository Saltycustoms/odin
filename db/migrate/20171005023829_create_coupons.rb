class CreateCoupons < ActiveRecord::Migration[5.1]
  def change
    create_table :coupons do |t|
      t.integer :discount_id
      t.string :name
      t.string :code
      t.datetime :from
      t.datetime :to

      t.timestamps
    end
  end
end
