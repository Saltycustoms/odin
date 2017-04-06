class AddBlankIdToOrderLine < ActiveRecord::Migration[5.0]
  def change
    add_column :order_lines, :blank_id, :integer
  end
end
