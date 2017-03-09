class CreateGateways < ActiveRecord::Migration[5.0]
  def change
    create_table :gateways do |t|
      t.string :name
      t.string :type
      t.boolean :disabled
      t.jsonb :properties

      t.timestamps
    end
  end
end
