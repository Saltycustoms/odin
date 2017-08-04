class AddDealTypeToDeals < ActiveRecord::Migration[5.1]
  def change
    add_column :deals, :deal_type, :integer, default: 0
  end
end
