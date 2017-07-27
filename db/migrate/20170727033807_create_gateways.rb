class CreateGateways < ActiveRecord::Migration[5.1]
  def change
    create_table :gateways do |t|
      t.string :name

      t.timestamps
    end
  end
end
