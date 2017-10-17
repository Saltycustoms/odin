class AddBillingAddressIdToPic < ActiveRecord::Migration[5.1]
  def change
    add_column :pics, :billing_address_id, :integer
  end
end
