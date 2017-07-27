class RemoveOrderFromTransactions < ActiveRecord::Migration[5.1]
  def change
    remove_reference :transactions, :order
  end
end
