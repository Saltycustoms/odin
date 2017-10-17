class AddTypeToGateway < ActiveRecord::Migration[5.1]
  def change
    add_column :gateways, :type, :string
  end
end
