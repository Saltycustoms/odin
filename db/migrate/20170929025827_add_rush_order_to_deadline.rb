class AddRushOrderToDeadline < ActiveRecord::Migration[5.1]
  def change
    add_column :deadlines, :rush_order, :boolean
  end
end
