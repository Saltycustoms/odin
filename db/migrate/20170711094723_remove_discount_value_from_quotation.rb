class RemoveDiscountValueFromQuotation < ActiveRecord::Migration[5.1]
  def change
    remove_column :quotations, :discount_value, :integer
  end
end
