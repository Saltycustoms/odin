class RemoveDealTypeFromDeals < ActiveRecord::Migration[5.1]
  def change
    remove_column :deals, :deal_type, :integer
  end
end
