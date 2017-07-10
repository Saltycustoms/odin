class RemoveClientDeadlineFromDeals < ActiveRecord::Migration[5.1]
  def change
    remove_column :deals, :client_deadline, :date
  end
end
