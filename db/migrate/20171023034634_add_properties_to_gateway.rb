class AddPropertiesToGateway < ActiveRecord::Migration[5.1]
  def change
    add_column :gateways, :properties, :jsonb
  end
end
