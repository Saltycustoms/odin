class AddDealToTransactions < ActiveRecord::Migration[5.1]
  def change
    add_reference :transactions, :deal, foreign_key: true
  end
end
