class AddRefToTransaction < ActiveRecord::Migration[5.1]
  def change
    add_column :transactions, :ref, :string
  end
end
