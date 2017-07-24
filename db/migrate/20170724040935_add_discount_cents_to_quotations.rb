class AddDiscountCentsToQuotations < ActiveRecord::Migration[5.1]
  def change
    add_column :quotations, :discount_amount_cents, :integer, default: 0
  end
end
